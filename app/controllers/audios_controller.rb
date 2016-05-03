require 'cgi' #Required for url_encode
include ESpeak #Required for audio functionality

class AudiosController < ApplicationController
  before_action :set_audio, only: [:show, :edit, :update, :destroy]
  before_action :create_audio_file, only: [:create]
  after_action :say_text, only: [:create]
  after_action :stream_audio, only: [:create]

  # GET /audios
  # GET /audios.json
  def index
    @audios = Audio.all
  end

  # GET /audios/1
  # GET /audios/1.json
  def show
  end

  # GET /audios/new
  def new
    @audio = Audio.new
  end

  # GET /audios/1/edit
  def edit
  end

  # POST /audios
  # POST /audios.json
  def create
    @url = 'http://10.0.190.50:3000/' + @audio_path # Creates the url to store
    respond_to do |format|
      if audio_params[:store] == "0" && @audio_path.present? # If stream only
        format.html { redirect_to new_audio_path, notice: 'Audio was sent for streaming.'}
        format.json { render :show, status: :created, location: @url }
      elsif audio_params[:store] == "1" && @audio_path.present? # If stream and save
        @audio = Audio.new({ :text => audio_params[:text], :url => @url })
        if @audio.save
          format.html { redirect_to @audio, notice: 'Audio was successfully created.' }
          format.json { render :show, status: :created, location: @url }
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

    @speech = Speech.new(params[:text])
    @speech.speak # invokes espeak
    @speech.save("public/audio/ass.mp3") # invokes espeak + lame

    # CHANGE THE --address IP TO YOUR MACHINE'S EXTERNAL IP
    @err1 = Thread.new{ @cast1 = `castnow --address 10.0.190.83 http://10.0.190.38:9292/audio/ass.mp3`}
    @err2 = Thread.new{ @cast2 = `castnow --address 10.0.190.67 http://10.0.190.38:9292/audio/ass.mp3`}
    @err3 = Thread.new{ @cast3 = `castnow --address 10.0.190.63 http://10.0.190.38:9292/audio/ass.mp3`}


    respond_to do |format|
      res = {
          :text => "Success!"
      }
      format.json { render :json => res, :status => 200 }
    end
  end

  # PATCH/PUT /audios/1
  # PATCH/PUT /audios/1.json
  def update
    respond_to do |format|
      if @audio.update(audio_params)
        format.html { redirect_to @audio, notice: 'Audio was successfully created.' }
        format.json { render :show, status: :ok, location: 'http://10.0.190.50/' + @audio_path }
      else
        format.html { render :edit }
        format.json { render json: @audio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /audios/1
  # DELETE /audios/1.json
  def destroy
    @audio.destroy
    respond_to do |format|
      format.html { redirect_to audios_url, notice: 'Audio was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_audio
      @audio = Audio.find(params[:id])
    end

    # Create the audio files
    def create_audio_file
      @speech = Speech.new(audio_params[:text])
      @audio_path = "audio/" + audio_params[:text].downcase.tr(" ", "_").gsub(/[^0-9A-Za-z_]/, '') + ".mp3"
      @speech.save("public/" + @audio_path) # invokes espeak + lame
    end

    def delete_audio_file

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
      # @err4 = Thread.new{`curl -d '' 'http://<ip or host>:8060/launch/17846?streamformat=mp3&url=#{enc_url}'`}
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def audio_params
      params.require(:audio).permit(:text, :store)
    end
end
