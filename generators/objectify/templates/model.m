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

+ (NSString *)getRemoteCollectionName {
	return @"<%=file_name.pluralize%>";
}

-(void)dealloc
{
<%- file_name.camelize.constantize.columns.each do |col| -%>
	<%- unless col.name == "id" -%>
	[<%= col.name.camelize(:lower) -%> release];
	<%- else -%>
	[<%= file_name.camelize(:lower) -%>Id release];
	<%- end -%>
<% end %>
	[super dealloc];
}

@end