module PathsHelpers
  # Maps a path description to a path
  def path_to(description)
    case description 

    when /the default text editor/
      Fastest::Platform.default_text_editor

    else
      raise "Can't find path for #{description}\""
    end
  end
end

World(PathsHelpers)
