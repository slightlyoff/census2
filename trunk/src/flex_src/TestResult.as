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

  [Bindable]
  public class TestResult
  {
    public var id:String;
    public var name:String;
    public var serverExecTime:Number;
    public var transferTime:Number;
    public var parseTime:Number;
    public var renderTime:Number;
    public var bandwidth:Number;
    public var memory:Number;
    public var rows:Number;

    public function TestResult(id:String)
    {
      this.id = id;
      name = "";
      serverExecTime = 0;
      transferTime = 0;
      parseTime = 0;
      renderTime = 0;
      bandwidth = 0;
      memory = 0;
      rows = 0;
    }
  }
}
