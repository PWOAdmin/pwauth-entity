with AUnit.Reporter.Text;
with AUnit.Run;
with Test_Lib; use Test_Lib;
use AUnit;
procedure Test_Driver is
   procedure Runner is new AUnit.Run.Test_Runner (Suite);
   Reporter : AUnit.Reporter.Text.Text_Reporter;
begin
   Runner (Reporter);
end Test_Driver;
