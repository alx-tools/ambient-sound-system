include ESpeak

class AudiosController < ApplicationController
  before_action :set_audio, only: [:show, :edit, :update, :destroy]

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
    @audio = Audio.new(audio_params)

    @speech = Speech.new(audio_params[:text])
    @speech.speak # invokes espeak

    respond_to do |format|
      if @audio.save
        format.html { redirect_to @audio, notice: 'Audio was successfully created.' }
        format.json { render :show, status: :created, location: @audio }
        @speech.save("public/audio/ass.mp3") # invokes espeak + lame

        # Three threads for three chromecasts. CHANGE THE --address IP TO YOUR MACHINE'S EXTERNAL IP
        @err1 = Thread.new{ @cast1 = `castnow --address 10.0.190.83 http://10.0.190.38:9292/audio/ass.mp3`}
        @err2 = Thread.new{ @cast2 = `castnow --address 10.0.190.67 http://10.0.190.38:9292/audio/ass.mp3`}
        @err3 = Thread.new{ @cast3 = `castnow --address 10.0.190.63 http://10.0.190.38:9292/audio/ass.mp3`}

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
        format.html { redirect_to @audio, notice: 'Audio was successfully updated.' }
        format.json { render :show, status: :ok, location: @audio }
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def audio_params
      params.require(:audio).permit(:text)
    end
end
