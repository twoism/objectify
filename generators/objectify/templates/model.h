#import "ObjectiveResource.h"
<%-
def objc_type type
	case 
		when type.match(/^int/)
			"NSNumber"
		when type.match(/varchar/)
			"NSString"
		when type.match(/tinyint/)
			"NSString"
		when type.match(/text/)
			"NSString"
		when type.match(/date/)
			"NSDate"
		else
			"NSString"
		end
end 
-%>

@interface <%= file_name.camelize %> : NSObject {
<%- file_name.camelize.constantize.columns.each do |col| -%>
	<%- unless col.name == "id" -%>
	<%=objc_type col.sql_type%> *<%= col.name.camelize(:lower) -%>;
	<%- else -%>
	<%=objc_type col.sql_type%> *<%= file_name.camelize(:lower) -%>Id;
	<%- end -%>
<% end %>
}
<%- file_name.camelize.constantize.columns.each do |col| -%>
<%- unless col.name == "id" -%>
@property (nonatomic, retain) <%=objc_type col.sql_type%> *<%= col.name.camelize(:lower) -%>;
<%- else -%>
@property (nonatomic, retain) <%=objc_type col.sql_type%> *<%= file_name.camelize(:lower) -%>Id;
<%- end -%>
<% end %>

@end