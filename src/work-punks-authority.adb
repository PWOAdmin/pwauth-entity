pragma Ada_2012;
package body work.punks.Authority is

      type User_Ptr is access all User_Type;

   -------------------
   -- Set_User_Name --
   -------------------

   procedure Set_User_Name (User_Ptr : in out User_Access; User_Name : in String)
   is
   begin
     User_Ptr.User_Name:=To_Unbounded_String(User_Name);
   end Set_User_Name;

   -------------------
   -- Get_User_Name --
   -------------------

   function Get_User_Name (User_Ptr : User_Access) return String is
   begin
   return To_String (User_Ptr.User_Name);
   end Get_User_Name;

procedure Free is
     new Ada.Unchecked_Deallocation(User_Type, User_Ptr);

   procedure Free_User(User_P : in out User_Access) is
   Temp : User_Ptr;
begin
   if User_P /= null then
      -- Convert class-wide to specific access type
      Temp := User_Ptr(User_P);
      Free(Temp);
      User_P := null;
   end if;
end Free_User;


end work.punks.Authority;
