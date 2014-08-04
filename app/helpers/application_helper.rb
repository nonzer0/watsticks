module ApplicationHelper

  def full_title(page_title)
    base_title = "Watsticks"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def bootstrap_class_for(flash_type)
    {
      success: "alert-success",
        error: "alert-danger",
        alert: "alert-warning",
       notice: "alert-info"
    }[flash_type] || flash_type.to_s
  end
end
