with Ada.Text_IO;                use Ada.Text_IO;
with Ada.Command_Line;           use Ada.Command_Line;
with Ada.Real_Time;              use Ada.Real_Time;
with Ada.Numerics.Float_Random;  use Ada.Numerics.Float_Random;

procedure Test_Dining_Philosophers is
   PhilosophersNum : constant Integer := Integer'Value (Argument (1));
   MealsNum : constant Integer := Integer'Value (Argument (2));

   protected type Fork is
      entry Pick_Up;
      procedure Put_Down;
   private
      Taken : Boolean := False;
   end Fork;
   
   protected body Fork is
      entry Pick_Up when not Taken is
      begin
         Taken := True;
      end Pick_Up;
      procedure Put_Down is
      begin
         Taken := False;
      end Put_Down;
   end Fork;
   

   task type Philosopher (ID : Integer; First, Second : not null access Fork);
   task body Philosopher is
      Last_Meal_Time : Time := Ada.Real_Time.Clock;
   begin
         
      for Life_Cycle in 1..MealsNum loop

         Put_Line ( Integer'Image (ID) & " mysli" & Life_Cycle'Image);   
       
         -- czas myslenia
         delay Duration ( 0.001 );

         First.Pick_Up;
         Put_Line (Integer'Image (ID) & " Podnosi Lewy");
         Second.Pick_Up;
         Put_Line (Integer'Image (ID) & " Podnosi Prawy");
   
         while Ada.Real_Time.Clock - Last_Meal_Time > Ada.Real_Time.Milliseconds(6) loop
            Put_Line (Integer'Image (ID) & " Umarl z glodu");
         end loop;

         Put_Line (Integer'Image (ID) & " Je"  & Life_Cycle'Image & " Posilek");
      
         -- czas jedzenia
         delay Duration ( 0.001 );

         Last_Meal_Time := Ada.Real_Time.Clock;

         Second.Put_Down;
         Put_Line (Integer'Image (ID) & " Odklada Prawy");
         First.Put_Down;
         Put_Line (Integer'Image (ID) & " Odklada Lewy");
         
      end loop;
      Put_Line (Integer'Image (ID) & " konczy zycie");
   end Philosopher;

   Forks : array (1..PhilosophersNum) of aliased Fork; 
   Philosophers : array (1..PhilosophersNum) of access Philosopher;

begin
   
   for I in 1..PhilosophersNum loop
      if I mod 2 = 0 then
         Philosophers(I) := new Philosopher (I, Forks((I mod PhilosophersNum) + 1)'Access, Forks(I)'Access);
      else
         Philosophers(I) := new Philosopher (I, Forks(I)'Access, Forks((I mod PhilosophersNum) + 1)'Access);
      end if;
   end loop;

end Test_Dining_Philosophers;