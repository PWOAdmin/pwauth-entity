with AUnit;
with AUnit.Simple_Test_Cases;

package User_Json_Test is
   type Should_Read_User_From_Json_Test is new AUnit.Simple_Test_Cases.Test_Case with null record;
   type Should_Write_Json_Normalizes_Test is new AUnit.Simple_Test_Cases.Test_Case with null record;
   type Should_Raise_On_Invalid_Json_Test is new AUnit.Simple_Test_Cases.Test_Case with null record;
   type Should_Handle_Unicode_Name_Test is new AUnit.Simple_Test_Cases.Test_Case with null record;
   type Should_Roundtrip_User_Test is new AUnit.Simple_Test_Cases.Test_Case with null record;

   function Name (T : Should_Read_User_From_Json_Test) return AUnit.Message_String;
   function Name (T : Should_Write_Json_Normalizes_Test) return AUnit.Message_String;
   function Name (T : Should_Raise_On_Invalid_Json_Test) return AUnit.Message_String;
   function Name (T : Should_Handle_Unicode_Name_Test) return AUnit.Message_String;
   function Name (T : Should_Roundtrip_User_Test) return AUnit.Message_String;

   procedure Run_Test (T : in out Should_Read_User_From_Json_Test);
   procedure Run_Test (T : in out Should_Write_Json_Normalizes_Test);
   procedure Run_Test (T : in out Should_Raise_On_Invalid_Json_Test);
   procedure Run_Test (T : in out Should_Handle_Unicode_Name_Test);
   procedure Run_Test (T : in out Should_Roundtrip_User_Test);

private
   procedure Should_Read_User_From_Json;
   procedure Should_Write_Json_Normalizes;
   procedure Should_Roundtrip_User;
   procedure Should_Raise_On_Invalid_Json;
   procedure Should_Handle_Unicode_Name;

end User_Json_Test;
