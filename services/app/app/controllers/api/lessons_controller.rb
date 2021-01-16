# frozen_string_literal: true

class Api::LessonsController < Api::ApplicationController
  before_action :require_api_auth!

  def check
    lesson = Language::Lesson.find(params[:id])
    language = lesson.language
    lesson_version = language.current_lesson_versions.find(params[:version_id])
    code = params[:data][:attributes][:code]

    language_version = lesson_version.language_version
    lesson_exercise_data = LessonTester.new.run(lesson_version, language_version, code, current_user)

    if lesson_exercise_data[:passed]
      lesson_member = lesson.members.find_by!(user: current_user)
      lesson_member.finish!

      language_member = language.members.find_or_create_by!(user: current_user)
      language_member.finish! if language_member.may_finish?
    end

    render json: {
      attributes: lesson_exercise_data
    }, status: :ok
  end
end
