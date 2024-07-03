package body Raylib is

   procedure Init_Window
     (Width :    Integer := 640; Height : Integer := 320;
      Title : in String  := "My new Raylib Game")
   is
   begin
      C_Init_Window (int (Width), int (Height), To_C (Title));
   end Init_Window;

   procedure Clear_Background (C : Color) is
   begin
      Clear_Background (To_C (C));
   end Clear_Background;

   procedure Draw_Rectangle
     (Pos_X, Pos_Y : Integer; Width, Height : Natural; C : Color)
   is
   begin
      Draw_Rectangle
        (int (Pos_X), int (Pos_Y), int (Width), int (Height), To_C (C));
   end Draw_Rectangle;

   procedure Set_Config_Flags (Flags : Unsigned_32) is
   begin
      Set_Config_Flags (unsigned (Flags));
   end Set_Config_Flags;

   procedure Draw_Rectangle_V (Position : Vector2; Size : Vector2; C : Color)
   is
   begin
      Draw_Rectangle_V (To_C (Position), To_C (Size), To_C (C));
   end Draw_Rectangle_V;

   procedure Begin_Mode2D (Camera : Camera2D) is
   begin
      Begin_Mode2D (To_C (Camera));
   end Begin_Mode2D;

   procedure Draw_Circle
     (Center_X, Center_Y : Integer; Radius : Float; C : Color)
   is
   begin
      Draw_Circle (int (Center_X), int (Center_Y), C_float (Radius), To_C (C));
   end Draw_Circle;

   procedure Draw_Circle_V (Center : Vector2; Radius : Float; C : Color) is
   begin
      Draw_Circle_V (To_C (Center), C_float (Radius), To_C (C));
   end Draw_Circle_V;

   procedure Draw_Text
     (Text : String; Pos_X, Pos_Y : Integer; FontSize : Integer; C : Color)
   is
   begin
      Draw_Text
        (To_C (Text), int (Pos_X), int (Pos_Y), int (FontSize), To_C (C));
   end Draw_Text;

   --  procedure Draw_Text_Ex
   --    (F       : Font; Text : String; Position : Vector2; Font_Size : Float;
   --                                                        Spacing : Float; Tint : Color) is
   --  begin
   --     Draw_Text_Ex(To_C(F), To_C(Text), To_C(Position), C_Float(Font_Size), C_Float(Spacing), To_C(Tint));
   --  end;

   procedure Set_Target_FPS (FPS : Integer) is
   begin
      Set_Target_FPS (int (FPS));
   end Set_Target_FPS;

   procedure Draw_FPS (Pos_X, Pos_Y : Integer) is
   begin
      Draw_FPS (int (Pos_X), int (Pos_Y));
   end Draw_FPS;

   procedure Set_Exit_Key (Key : Integer) is
   begin
      Set_Exit_Key (int (Key));
   end Set_Exit_Key;

   procedure Draw_Triangle (V1, V2, V3 : Vector2; C : Color) is
   begin
      Draw_Triangle (To_C (V1), To_C (V2), To_C (V3), To_C (C));
   end Draw_Triangle;

   procedure Draw_Triangle_Strip (Points : Vector2_Array; C : Color) is
   begin
      Draw_Triangle_Strip(To_C(Points), To_C(Color));
   end;

   procedure Play_Music_Stream (M : Music) is
   begin
      Play_Music_Stream (To_C (M));
   end Play_Music_Stream;

   procedure Stop_Music_Stream (M : Music) is
   begin
      Stop_Music_Stream (To_C (M));
   end Stop_Music_Stream;

   procedure Update_Music_Stream (M : Music) is
   begin
      Update_Music_Stream (To_C (M));
   end Update_Music_Stream;

   procedure Set_Music_Volume (M : Music; Volume : Float) is
   begin
      Set_Music_Volume (To_C (M), C_float (Volume));
   end Set_Music_Volume;

   procedure Play_Sound (S : Sound) is
   begin
      Play_Sound (To_C (S));
   end Play_Sound;

   procedure Set_Sound_Pitch (S : Sound; Pitch : Float) is
   begin
      Set_Sound_Pitch (To_C (S), C_float (Pitch));
   end Set_Sound_Pitch;

   procedure Set_Sound_Volume (S : Sound; Volume : Float) is
   begin
      Set_Sound_Volume (To_C (S), C_float (Volume));
   end Set_Sound_Volume;

   procedure Set_Window_Icon (Img : Image) is
   begin
      Set_Window_Icon (To_C (Img));
   end Set_Window_Icon;

   procedure Draw_Text_Ex
     (F       : Font; Text : String; Position : Vector2; Font_Size : Float;
                                                         Spacing : Float; Tint : Color) is
   begin
      Draw_Text_Ex(To_C(F), To_C(Text), To_C(Position), C_Float(Font_Size), C_Float(Spacing), To_C(Tint));
   end;
   
   procedure Gen_Texture_Mipmaps (T : access Texture2D) is
   begin
      C_Gen_Texture_Mipmaps(T.all);
   end;
   
end Raylib;
