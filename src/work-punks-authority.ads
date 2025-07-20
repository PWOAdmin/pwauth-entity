with Ada.Strings.Unbounded;
use Ada.Strings.Unbounded;

with Ada.Unchecked_Deallocation;

package work.punks.Authority is

   type User_Type is tagged private;
   type User_Access is access all User_Type'Class;


   
   procedure Set_User_Name (User_Ptr: in out User_Access; User_Name: in String);
   procedure Set_Enabled (User_Ptr: in out User_Access; Enabled: Boolean);

   function Get_User_Name (User_Ptr: User_Access ) return String;
   function Is_Enabled (User_Ptr: User_Access) return Boolean;

   procedure Free_User(User_P : in out User_Access);
    
   
private 
   type User_Type is tagged record
      
      User_Name: Unbounded_String;
      User_Enabled: Boolean;
      
      
   end record;
  
   

end work.punks.Authority;
