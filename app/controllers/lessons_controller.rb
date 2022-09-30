class LessonsController < ApplicationController
  before_action :set_lesson, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]

  # GET /lessons or /lessons.json
  def index
    @lessons = Lesson.order(created_at: :desc)
    @user_gid=current_user.to_gid_param if current_user 
    #.limit(2)
  end
  # GET /lessons/1 or /lessons/1.json
  def show
  end

  # GET /lessons/new
  def new
    @lesson = Lesson.new
  end

  # GET /lessons/1/edit
  def edit
   
  end

  # POST /lessons or /lessons.json
  def create
    @lesson = Lesson.new(lesson_params)

    respond_to do |format|
      if @lesson.save
          format.turbo_stream { render turbo_stream: turbo_stream.prepend( "private_lessons" , partial: "lessons/lesson", locals: {
            lesson: @lesson, join_status: current_user.joined?(@lesson) 
            })}
        format.turbo_stream do
          render turbo_stream: turbo_stream.prepend("lessons", partial: "lessons/lesson", locals: {lesson: @lesson, join_status: current_user.joined?(@lesson) })
        end
        format.html { redirect_to lesson_url(@lesson), notice: "Lesson was successfully created." }
        format.json { render :show, status: :created, location: @lesson }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lessons/1 or /lessons/1.json
  def update 
    if @lesson.user_id != current_user.id
       correct_user
      else
    respond_to do |format|
     
      if @lesson.update(lesson_params)
        format.turbo_stream { render turbo_stream: turbo_stream.replace( "#{helpers.dom_id(@lesson)}_lesson",partial: "lessons/lesson", locals: {
          lesson: @lesson, join_status: current_user.joined?(@lesson) 
          })}
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(@lesson, partial: "lessons/lesson", locals: {lesson: @lesson})
        end
        format.html { redirect_to lesson_url(@lesson), notice: "Lesson was successfully updated." }
        format.json { render :show, status: :ok, location: @lesson }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end
  end

  def set_current_user
    Current.user = current_user
  end

  
  def correct_user
    @frind = current_user.lessons.find_by(id: params[:id])
    redirect_to root_path, notice: "Not Authorized To Edit This lesson" if @lesson.nil?
  end

  # DELETE /lessons/1 or /lessons/1.json
  def destroy
    @lesson.destroy

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove("#{helpers.dom_id(@lesson)}_lesson")}
      format.html { redirect_to todos_url, notice: "Todo was successfully destroyed." }
      format.json { head :no_content }
      format.turbo_stream do
        render turbo_stream: turbo_stream.remove(@lesson, partial: "lessons/lesson", locals: {lesson: @lesson})
      end
      format.html { redirect_to lessons_url, notice: "Lesson was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def join
    @lesson = Lesson.find(params[ :id])
    current_user.join(@lesson)
    respond_to do |format|
      format.turbo_stream do 
        render turbo_stream: private_stream
      end
    end
  end

  private

  def private_stream
    private_target = "#{helpers.dom_id(@lesson)} private_joins"
    turbo_stream.replace(private_target, 
                          partial: 'joins/private_button',
                          locals:{
                            lesson: @lesson,
                            join_status: current_user.joined?(@lesson)
                        })
  end
                 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lesson
      @lesson = Lesson.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def lesson_params
      params.require(:lesson).permit(:topic, :field, :description, :user_id)
    end
end
