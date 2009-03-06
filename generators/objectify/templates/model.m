#import "<%=file_name.camelize%>"
<%-
def do_synth mdl
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
-%>
@implementation <%=file_name.camelize%>
@synthesize <%=do_synth file_name%>

@end