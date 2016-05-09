require 'cgi' #Required for url_encode
include ESpeak #Required for audio functionality

class AudiosController < ApplicationController
  # GET /audios
  # GET /audios.json
  def index
    @audios = Audio.all
  end

  # GET /audios/1
  # GET /audios/1.json
  def show
    @audio = set_audio
  end

  # GET /audios/new
  def new
    @audio = Audio.new
  end

  # GET /audios/1/edit
  def edit
    @audio = set_audio
  end

  # POST /audios
  # POST /audios.json
  def create
    @audio = Audio.new
    @file = set_file_name(audio_params[:text])
    @url = @audio.url_path + @file # Creates the url to store
    @file_path = @audio.path + @file
    create_file = create_audio_file(audio_params[:text])
    say_text
    stream_audio

    respond_to do |format|
      if audio_params[:store] == "0" && @file_path.present? # If stream only
        delete_stream_file
        format.html { redirect_to new_audio_path, notice: 'Audio was sent for streaming.'}
        format.json { render :show, status: :created, location: @url }
      elsif audio_params[:store] == "1" && @file_path.present? # If stream and save
        @audio = Audio.new({ :text => audio_params[:text], :file => @file })
        if @audio.save
          format.html { redirect_to @audio, notice: 'Audio was successfully created.' }
          format.json { render :show, status: :created, location: @file }
        else
          format.html { render :new }
          format.json { render json: @audio.errors, status: :unprocessable_entity }
        end
      else
        format.html { render :new }
        format.json { render json: @audio.errors, status: :unprocessable_entity }
      end
    end
  end

  def ass_bot
    @audio = Audio.new
    @file = set_file_name(params[:text])
    @url = @audio.url_path + @file # Creates the url to store
    @file_path = @audio.path + @file
    create_file = create_audio_file(params[:text])
    said = say_text
    stream = stream_audio

    res = {
        :text => "Success!",
        :status => 200
    }
    render json: res
  end

  # PATCH/PUT /audios/1
  # PATCH/PUT /audios/1.json
  def update
    @file = set_file_name
    @audio = set_audio
    @delete_file = delete_audio_file
    @create_file = create_audio_file(audio_params[:text])
    respond_to do |format|
      if @audio.update({ :text => audio_params[:text], :file => @file })
        format.html { redirect_to @audio, notice: 'Audio was successfully created.' }
        format.json { render :show, status: :ok, location: @audio.url_path + @file }
      else
        format.html { render :edit }
        format.json { render json: @audio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /audios/1
  # DELETE /audios/1.json
  def destroy
    @audio = set_audio
    @delete_file = delete_audio_file
    @audio.destroy
    respond_to do |format|
      format.html { redirect_to audios_url, notice: 'Audio was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_file_name(text)
      text.downcase.tr(" ", "_").gsub(/[^0-9A-Za-z_]/, '') + ".mp3"
    end

    def set_audio
      Audio.find(params[:id])
    end

    # Create the audio files
    def create_audio_file(text)
      @speech = Speech.new(text)
      @speech.save(@file_path) # invokes espeak + lame
    end

    def delete_audio_file
      Thread.new{ `rm #{@audio.file_path}` }
    end

    def delete_stream_file
      Thread.new{ sleep(1.minute); `rm #{@file_path}`}
    end

    # Immediately speaks the text
    def say_text
      @speech.speak # invokes espeak
    end

    def stream_audio
      # Three threads for three chromecasts. final argument's ip needs to be changed to appropriate server machine's external ip.
      enc_url = CGI::escape(@url)
      # Chromecast Command
      # @err1 = Thread.new{ @cast1 = `castnow --address 10.0.190.83 #{@url}`}
      # @err2 = Thread.new{ @cast2 = `castnow --address 10.0.190.67 #{@url}`}
      # @err3 = Thread.new{ @cast3 = `castnow --address 10.0.190.63 #{@url}`}
      # Roku Command
      # @err4 = Thread.new{`curl -d '' 'http://<IP or HOSTNAME>:8060/launch/17846?streamformat=mp3&url=#{enc_url}'`}
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def audio_params
      if !params[:text]
        params.require(:audio).permit(:text, :store)
      else
        params.permit(:text)
      end
    end
end
