pragma Ada_2012;
package body work.punks.Authority is

   type User_Ptr is access all User_Type;

   -------------------
   -- Set_User_Name --
   -------------------

   procedure Set_User_Name (User_Ptr : access User_Type'Class; User_Name : in String) is
   begin
      User_Ptr.User_Name := To_Unbounded_String (User_Name);
   end Set_User_Name;

   -------------------
   -- Get_User_Name --
   -------------------

   function Get_User_Name (User_Ptr : access User_Type'Class) return String is
   begin
      return To_String (User_Ptr.User_Name);
   end Get_User_Name;

   procedure Set_Enabled (User_Ptr : access User_Type'Class; Enabled : Boolean) is
   begin
      User_Ptr.User_Enabled := Enabled;
   end Set_Enabled;

   function Is_Enabled (User_Ptr : access User_Type'Class) return Boolean is
   begin
      return User_Ptr.User_Enabled;
   end Is_Enabled;

   function To_JSON (User_P : access User_Type'Class) return String is
      Obj : JSON.JSON_Value := JSON.Create_Object;
   begin
      Obj.Set_Field ("User_Name", User_P.User_Name);
      Obj.Set_Field ("User_Enabled", User_P.User_Enabled);
      return Obj.Write;
   end To_JSON;

   function From_JSON (Json_String : String) return User_Access is
      Value  : JSON.JSON_Value := JSON.Read (Json_String);
      Result : User_Access     := new User_Type;

   begin

      Result.Set_User_Name (Value.Get ("User_Name"));
      -- Non required fields
      declare
         User_Enabled : Boolean := false;
      begin

         if Value.Has_Field ("User_Enabled") = true then
            Result.Set_Enabled (true);
         end if;
      end;
      return Result;
   end From_JSON;

   procedure Free is new Ada.Unchecked_Deallocation (User_Type, User_Ptr);

   procedure Free_User (User_P : in out User_Access) is
      Temp : User_Ptr;
   begin
      if User_P /= null then
         -- Convert class-wide to specific access type
         Temp := User_Ptr (User_P);
         Free (Temp);
         User_P := null;
      end if;
   end Free_User;

end work.punks.Authority;
