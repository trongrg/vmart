class HomepageController < ApplicationController
  layout :resolve_layout

  def index

  end

  def about

  end

  def contact

  end

  private
  def resolve_layout
    case action_name
    when 'index'
      'application'
    when 'about'
      false
    end
  end
end
