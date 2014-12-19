module ApplicationHelper
  def javascript(*files)
    content_for(:head) { javascript_include_tag(*files)}
  end
  
  def sortable(column,title=nil)
    title||=column.titleize
    css_class=column==sort_column ? "current #{sort_direction}" : nil
    direction=column==sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, params.merge(:sort=>column,:direction=>direction,:created_at=>params[:created_at]),{:class=>css_class}
  end
end
