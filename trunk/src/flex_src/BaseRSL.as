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
import flash.display.Sprite;
import mx.core.Application;
import mx.controls.DataGrid;

public class BaseRSL extends Sprite
{
  private var application:Application;
  private var dataGrid:DataGrid;
  private var testResult:TestResult;

  [Embed(source="Vera.ttf", fontFamily="myriadWebPro")]
  public static var myriadWebPro:Class;

  [Embed(source="VeraBd.ttf", fontFamily="myriadWebPro", fontWeight="bold")]
  public static var myriadWebProBold:Class;
}
}
