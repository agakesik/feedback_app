module ApplicationHelper

  # Returns page type: spreadshit or single page
  def page_type(page_type = '')
    if page_type.empty?
      "single-page"
    else
      "spreadsheet-page"
    end
  end

end
