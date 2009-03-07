#import "<%=file_name.camelize%>.h"
<%-

-%>
@implementation <%=file_name.camelize%>
@synthesize <%= synthesize_cols file_name%>

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