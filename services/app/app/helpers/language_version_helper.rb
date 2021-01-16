# frozen_string_literal: true

module LanguageVersionHelper
  def language_version_state_class(state)
    case state
    when 'created'
      'badge badge-secondary'
    when 'building'
      'badge badge-warning'
    when 'built'
      'badge badge-success'
    end
  end
end
