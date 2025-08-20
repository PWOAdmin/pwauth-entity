with AUnit.Simple_Test_Cases; use AUnit.Simple_Test_Cases;
with User_Json_Test;
package body Test_Lib is

   function Suite return Access_Test_Suite is
      Ret : constant Access_Test_Suite := new Test_Suite;
   begin
      Ret.Add_Test (Test_Case_Access'(new User_Json_Test.Should_Handle_Unicode_Name_Test));
      Ret.Add_Test (Test_Case_Access'(new User_Json_Test.Should_Raise_On_Invalid_Json_Test));
      Ret.Add_Test (Test_Case_Access'(new User_Json_Test.Should_Read_User_From_Json_Test));
      Ret.Add_Test (Test_Case_Access'(new User_Json_Test.Should_Roundtrip_User_Test));
      Ret.Add_Test (Test_Case_Access'(new User_Json_Test.Should_Write_Json_Normalizes_Test));
      return Ret;
   end Suite;

end Test_Lib;
