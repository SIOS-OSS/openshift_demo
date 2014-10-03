class QuestionsController < ApplicationController
  include ActionController::Live

  before_action :set_question, only: [:stream, :get_status, :show, :streaming_graph, :edit, :update, :destroy, :increment]

  def redirect
    redirect_to action: :show, id: 1
  end

  def stream
    response.headers['Content-Type'] = 'text/event-stream'

    6000.times do |i|
      ActiveRecord::Base.connection_pool.with_connection do
        Question.uncached do
          set_question
        end
      end

      response.stream.write("event: message\n")
      response.stream.write("data: #{create_json_response.to_json}\n\n")
      sleep 1
    end

    response.stream.write("event: done\n")
    response.stream.write("data: done\n\n")
  ensure
    response.stream.close
  end

  def get_status
      render json: create_json_response.to_json
  end
  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.all
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
  end

  def stream_show
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render action: 'show', status: :created, location: @question }
      else
        format.html { render action: 'new' }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url }
      format.json { head :no_content }
    end
  end

  def increment
    @question.increment!(params[:q])
    render json: create_json_response, status: 200
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:title, :q_1, :q_1_count, :q_2, :q_2_count, :q_3, :q_3_count, :q_4, :q_4_count)
    end

    def create_json_response
      [
        {label: @question.q_1, value: @question.q_1_count},
        {label: @question.q_2, value: @question.q_2_count},
        {label: @question.q_3, value: @question.q_3_count},
        {label: @question.q_4, value: @question.q_4_count},
      ]
    end
end
