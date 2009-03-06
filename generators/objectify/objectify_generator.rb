class ObjectifyGenerator < Rails::Generator::NamedBase
  
  def manifest 
    if file_name.camelize.constantize
      record do |m|
        FileUtils.mkdir_p "lib/objc"
        m.template "model.h", "lib/objc/#{file_name.camelize}.h"
        m.template "model.m", "lib/objc/#{file_name.camelize}.m"
      end
    end
  end
end