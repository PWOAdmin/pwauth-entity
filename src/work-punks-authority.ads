with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

with Ada.Unchecked_Deallocation;

with GNATCOLL.JSON; use GNATCOLL;

package work.punks.Authority is

   type User_Type is tagged private;
   type User_Access is access all User_Type'Class;

   procedure Set_User_Name (User_Ptr : access User_Type'Class; User_Name : in String);
   procedure Set_Enabled (User_Ptr : access User_Type'Class; Enabled : Boolean);

   function Get_User_Name (User_Ptr : access User_Type'Class) return String;
   function Is_Enabled (User_Ptr : access User_Type'Class) return Boolean;

   procedure Free_User (User_P : in out User_Access);

   function To_JSON (User_P : access User_Type'Class) return String;

   function From_JSON (Json_String : String) return User_Access;

private
   type User_Type is tagged record

      User_Name    : Unbounded_String;
      User_Enabled : Boolean := False;
      Robot: Boolean:=false;

   end record;

end work.punks.Authority;
