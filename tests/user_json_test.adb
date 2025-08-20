with AUnit.Assertions;     use AUnit.Assertions;
with Work.Punks.Authority; use Work.Punks.Authority;

package body User_Json_Test is

   function Name (T : Should_Read_User_From_Json_Test) return AUnit.Message_String is
      pragma Unreferenced (T);
   begin
      return AUnit.Format ("User JSON: Read User From JSON text");
   end Name;
   function Name (T : Should_Write_Json_Normalizes_Test) return AUnit.Message_String is
      pragma Unreferenced (T);
   begin
      return AUnit.Format ("User JSON: Write JSON Normalizes text");
   end Name;
   function Name (T : Should_Raise_On_Invalid_Json_Test) return AUnit.Message_String is
      pragma Unreferenced (T);
   begin
      return AUnit.Format ("User JSON: Raise an exception when invalid JSON");
   end Name;
   function Name (T : Should_Handle_Unicode_Name_Test) return AUnit.Message_String is
      pragma Unreferenced (T);
   begin
      return AUnit.Format ("User JSON: Handle Unicode names");
   end Name;
   function Name (T : Should_Roundtrip_User_Test) return AUnit.Message_String is
      pragma Unreferenced (T);
   begin
      return AUnit.Format ("User JSON: read/write & roundtrip");
   end Name;

   -- Helpers
   procedure Assert_Eq_String (Expected, Actual, Field : String) is
   begin
      Assert
        (Expected = Actual,
         "Field """ & Field & """ mismatch: expected=""" & Expected & """ actual=""" & Actual & """");
   end Assert_Eq_String;

   procedure Assert_Eq_Bool (Expected, Actual : Boolean; Field : String) is
   begin
      Assert
        (Expected = Actual,
         "Field """ & Field & """ mismatch: expected=" & Boolean'Image (Expected) & " actual="
         & Boolean'Image (Actual));
   end Assert_Eq_Bool;

   procedure Run_Test (T : in out Should_Read_User_From_Json_Test) is
      pragma Unreferenced (T);
   begin
      Should_Read_User_From_Json;
   end Run_Test;

   procedure Run_Test (T : in out Should_Write_Json_Normalizes_Test) is
      pragma Unreferenced (T);
   begin
      Should_Write_Json_Normalizes;
   end Run_Test;
   procedure Run_Test (T : in out Should_Raise_On_Invalid_Json_Test) is
      pragma Unreferenced (T);
   begin
      Should_Raise_On_Invalid_Json;
   end Run_Test;
   procedure Run_Test (T : in out Should_Handle_Unicode_Name_Test) is
      pragma Unreferenced (T);
   begin
      Should_Handle_Unicode_Name;
   end Run_Test;
   procedure Run_Test (T : in out Should_Roundtrip_User_Test) is
      pragma Unreferenced (T);
   begin
      Should_Roundtrip_User;
   end Run_Test;

   procedure Should_Read_User_From_Json is
      User_T      : User_Access;
      JSON_String : constant String := "{""User_Name"":""testName""}";
   begin
      User_T := From_JSON (JSON_String);
      Assert (User_T /= null, "From_JSON returned null");
      Assert_Eq_String ("testName", Get_User_Name (User_T), "User_Name");

   end Should_Read_User_From_Json;

   procedure Should_Write_Json_Normalizes is
      Expected_Name    : constant String  := "Mike";
      Expected_Enabled : constant Boolean := True;

      U : User_Access := new User_Type;
   begin
      U.Set_User_Name (Expected_Name);
      U.Set_Enabled (Expected_Enabled);

      declare
         Actual_Json : constant String      := U.To_JSON;
         U2          : constant User_Access := From_JSON (Actual_Json);
      begin
         Assert (U2 /= null, "Roundtrip parse produced null");
         Assert_Eq_String (Expected_Name, Get_User_Name (U2), "User_Name");
         Assert_Eq_Bool (Expected_Enabled, Is_Enabled (U2), "User_Enabled");
      end;
   end Should_Write_Json_Normalizes;

   procedure Should_Roundtrip_User is
      Input_Json : constant String := "{""User_Enabled"":true,""User_Name"":""Alice""}";
      U1         : User_Access     := From_JSON (Input_Json);
   begin
      Assert (U1 /= null, "From_JSON returned null");
      declare
         Json2 : constant String      := U1.To_JSON;
         U2    : constant User_Access := From_JSON (Json2);
      begin
         Assert (U2 /= null, "Second From_JSON returned null");
         Assert_Eq_String (Get_User_Name (U1), Get_User_Name (U2), "User_Name");
         Assert_Eq_Bool (Is_Enabled (U1), Is_Enabled (U2), "User_Enabled");
      end;
   end Should_Roundtrip_User;

   procedure Should_Raise_On_Invalid_Json is
      Raised : Boolean := False;
   begin
      begin
         declare
            Junk : constant String := "{bad json";
            U    : User_Access     := From_JSON (Junk);
            pragma Unreferenced (U);
         begin
            null;
         end;
      exception
         when others =>
            Raised := True;
      end;
      Assert (Raised, "From_JSON must raise on invalid JSON");
   end Should_Raise_On_Invalid_Json;

   procedure Should_Handle_Unicode_Name is
      U  : User_Access     := new User_Type;
      Nm : constant String := "Željko-Миша";
   begin
      U.Set_User_Name (Nm);
      U.Set_Enabled (True);
      declare
         J  : constant String      := U.To_JSON;
         U2 : constant User_Access := From_JSON (J);
      begin
         Assert (U2 /= null, "Unicode roundtrip parse returned null");
         Assert_Eq_String (Nm, Get_User_Name (U2), "User_Name");
         Assert_Eq_Bool (True, Is_Enabled (U2), "User_Enabled");
      end;
   end Should_Handle_Unicode_Name;

end User_Json_Test;
