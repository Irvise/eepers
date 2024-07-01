package body Raymath is
   
   -------------------
   -- C Interfacing --
   -------------------
   function To_C(Vector : Vector2) return C_Vector2 is
      Temp : C_Vector2 := (X => To_C(Vector.X), Y => To_C(Vector.Y));
   begin
      return Temp;
   end;

   function To_C(Vector : Vector3) return C_Vector3 is
      Temp : Vector3_C := (X => To_C(Vector.X), Y => To_C(Vector.Y), Z => To_C(Vector.Z));
   begin
      return Temp;
   end;
   
   function To_Ada(Vector : C_Vector2) return Vector2 is
      Temp : Vector2 := (X => To_Ada(Vector.X), Y => To_Ada(Vector.Y));
   begin
      return Temp;
   end;

   function To_Ada(Vector : C_Vector3) return Vector3 is
      Temp : Vector3 := (X => To_Ada(Vector.X), Y => To_Ada(Vector.Y), Z => To_Ada(Vector.Z));
   begin
      return Temp;
   end;
   
   ---------------
   -- Functions --
   ---------------
   
   function "+"(a, b: Vector2) return Vector2 is
      function "+"(a, b: C_Vector2) return Vector2
        with
        Import => True,
        Convention => C,
        External_Name => "Vector2Add";
   begin
      return To_Ada(To_C(a) + To_C(b));
   end;
   
   function "-"(a, b: Vector2) return Vector2 is
      function "-"(a, b: C_Vector2) return Vector2
        with
        Import => True,
        Convention => C,
        External_Name => "Vector2Subtract";
   begin
      return To_Ada(To_C(a) - To_C(b));
   end;
   
   function "*"(a, b: Vector2) return Vector2 is
      function "*"(a, b: C_Vector2) return Vector2
        with
        Import => True,
        Convention => C,
        External_Name => "Vector2Multiply";
   begin
      return To_Ada(To_C(a) * To_C(b));
   end;
   
   function "*"(v: Vector2; scale: Float) return Vector2 is
      function "*"(v: C_Vector2; scale: C_Float) return Vector2
        with
        Import => True,
        Convention => C,
        External_Name => "Vector2Scale";
   begin
      return To_Ada(To_C(v) * To_C(scale));
   end;
   
   function Vector2_Rotate(V: Vector2; Angle: Float) return Vector2 is
      function Vector2_Rotate(V: C_Vector2; Angle: C_Float) return Vector2
        with
        Import => True,
        Convention => C,
        External_Name => "Vector2Rotate";
   begin
      return To_Ada(Vector2_Rotate(To_C(V), To_C(Angle)));
   end;
   
   function Vector2_Line_Angle(Start, Finish: Vector2) return Float is
      function Vector2_Line_Angle(Start, Finish: C_Vector2) return C_Float
        with
        Import => True,
        Convention => C,
        External_Name => "Vector2LineAngle";
   begin
      return To_Ada(Vector2_Line_Angle(To_C(Start), To_C(Finish)));
   end;
   
   function Vector2_Lerp(V1, V2: Vector2; Amount: Float) return Vector2 is
      function Vector2_Lerp(V1, V2: C_Vector2; Amount: C_Float) return Vector2
        with
        Import => True,
        Convention => C,
        External_Name => "Vector2Lerp";
   begin
      return To_Ada(Vector2_Lerp(To_C(V1), To_C(V2), To_C(Amount)));
   end;
   
end;
