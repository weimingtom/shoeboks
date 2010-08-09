package org.shoebox.biskwy.utils {
	import flash.geom.Vector3D;

	/**
	 * @author shoe[box]
	 */
	public interface ITransform {
		
		function screenToWorld( v : Vector3D ) :Vector3D;		function worldToScreen( v : Vector3D ) :Vector3D;
		
	}
}
