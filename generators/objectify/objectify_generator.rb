POINTER_TYPES = {
   :datetime  => "NSDate",
   :date      => "NSDate",
   :string    => "NSString",
   :text      => "NSString",
   :integer   => "NSNumber",
   :float     => "NSDecimalNumber",
   :double    => "NSDecimalNumber"
 }
class ObjectifyGenerator < Rails::Generator::NamedBase

  def objc_type type
    POINTER_TYPES[type]
  end
  
  def synthesize_cols mdl
  	file_name.camelize.constantize.columns.inject("") do |str,col|
  		unless col.name == "id" 
  			str << "#{col.name.camelize(:lower)}"
  		else
  			str << "#{file_name.camelize(:lower)}Id"
  		end
  		unless col == file_name.camelize.constantize.columns.last
  			str << ", "
  		else
  			str << ";"
  		end
  	end
  end
  
  
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