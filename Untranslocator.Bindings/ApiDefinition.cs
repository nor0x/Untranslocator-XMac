using Foundation;

namespace Untranslocator
{
	// @interface Untranslocator : NSObject
	[BaseType (typeof(NSObject))]
	interface Untranslocator
	{
		// -(NSString *)resolveTranslocatedPath:(NSString *)path;
		[Export ("resolveTranslocatedPath:")]
		string ResolveTranslocatedPath (string path);
	}
}
