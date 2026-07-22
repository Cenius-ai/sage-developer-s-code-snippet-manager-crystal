# View context — holds page-level variables accessible from all ECR templates.
module View
  class_property page_title : String = "Sage"
  class_property error_msg : String? = nil
  class_property form_title : String? = nil
  class_property form_language : String? = nil
  class_property form_content : String? = nil
  class_property query : String? = nil
  class_property snippets : Array(Snippet) = [] of Snippet
  class_property snippet : Snippet? = nil

  def self.reset!
    @@page_title = "Sage"
    @@error_msg = nil
    @@form_title = nil
    @@form_language = nil
    @@form_content = nil
    @@query = nil
    @@snippets = [] of Snippet
    @@snippet = nil
  end
end
