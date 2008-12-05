/*
Copyright (C) 2007 James Ward
http://www.jamesward.org

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License along
with this program; if not, write to the Free Software Foundation, Inc.,
51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
*/
package
{
  import mx.core.IUID;

  [Bindable]
  public class Test implements IUID
  {
    public var name:String;
    public var id:String;
    public var description:String;
    public var details:String;
    public var warnNumRows:Number;

    public function get uid():String
    {
      return id;
    }
    public function set uid(uid:String):void
    {
      id = uid;
    }

    public function Test(name:String, id:String, description:String, warnNumRows:Number, details:String="")
    {
      this.name = name;
      this.id = id;
      this.description = description;
      this.warnNumRows = warnNumRows;
      this.details = details;
    }
  }

}
