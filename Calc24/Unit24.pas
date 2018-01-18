unit Unit24;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Math, Buttons;

type
  TFormCalc = class(TForm)
    edt1: TEdit;
    edt2: TEdit;
    edt3: TEdit;
    edt4: TEdit;
    btnCalc: TButton;
    mmoResult: TMemo;
    mmoList: TMemo;
    Bevel1: TBevel;
    btnList: TButton;
    btnSave: TBitBtn;
    dlgSave: TSaveDialog;
    procedure btnCalcClick(Sender: TObject);
    procedure btnListClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
  private
    FRunning: Boolean;
  public
    { Public declarations }
  end;

var
  FormCalc: TFormCalc;

implementation

{$R *.DFM}

const
  // 数字位置的排列组合
  SUB_FIXES: array[0..23] of array[0..3] of Integer = (
    (0, 1, 2, 3), // 0
    (0, 1, 3, 2),
    (0, 2, 1, 3),
    (0, 2, 3, 1),
    (0, 3, 2, 1),
    (0, 3, 1, 2), // 1
    (1, 0, 2, 3),
    (1, 0, 3, 2),
    (1, 2, 0, 3),
    (1, 2, 3, 0),
    (1, 3, 2, 0),
    (1, 3, 0, 2),
    (2, 1, 0, 3), // 2
    (2, 1, 3, 0),
    (2, 0, 1, 3),
    (2, 0, 3, 1),
    (2, 3, 0, 1),
    (2, 3, 1, 0),
    (3, 1, 2, 0), // 3
    (3, 1, 0, 2),
    (3, 2, 1, 0),
    (3, 2, 0, 1),
    (3, 0, 2, 1),
    (3, 0, 1, 2)
  );

  // 四则运算符的排列组合
  OPERATORS: array[0..63] of array[0..2] of Char = (
    ('+', '+', '+'), // +
    ('+', '+', '-'),
    ('+', '+', '*'),
    ('+', '+', '/'),
    ('+', '-', '+'),
    ('+', '-', '-'),
    ('+', '-', '*'),
    ('+', '-', '/'),
    ('+', '*', '+'),
    ('+', '*', '-'),
    ('+', '*', '*'),
    ('+', '*', '/'),
    ('+', '/', '+'),
    ('+', '/', '-'),
    ('+', '/', '*'),
    ('+', '/', '/'),
    ('-', '+', '+'), // -
    ('-', '+', '-'),
    ('-', '+', '*'),
    ('-', '+', '/'),
    ('-', '-', '+'),
    ('-', '-', '-'),
    ('-', '-', '*'),
    ('-', '-', '/'),
    ('-', '*', '+'),
    ('-', '*', '-'),
    ('-', '*', '*'),
    ('-', '*', '/'),
    ('-', '/', '+'),
    ('-', '/', '-'),
    ('-', '/', '*'),
    ('-', '/', '/'),
    ('*', '+', '+'), // *
    ('*', '+', '-'),
    ('*', '+', '*'),
    ('*', '+', '/'),
    ('*', '-', '+'),
    ('*', '-', '-'),
    ('*', '-', '*'),
    ('*', '-', '/'),
    ('*', '*', '+'),
    ('*', '*', '-'),
    ('*', '*', '*'),
    ('*', '*', '/'),
    ('*', '/', '+'),
    ('*', '/', '-'),
    ('*', '/', '*'),
    ('*', '/', '/'),
    ('/', '+', '+'), // /
    ('/', '+', '-'),
    ('/', '+', '*'),
    ('/', '+', '/'),
    ('/', '-', '+'),
    ('/', '-', '-'),
    ('/', '-', '*'),
    ('/', '-', '/'),
    ('/', '*', '+'),
    ('/', '*', '-'),
    ('/', '*', '*'),
    ('/', '*', '/'),
    ('/', '/', '+'),
    ('/', '/', '-'),
    ('/', '/', '*'),
    ('/', '/', '/')
  );

  // 括号的排列组合，括号处于以下位置
  //    A * B * C * D
  //   ^   ^ ^ ^ ^   ^
  //   0   1 2 3 4   5
  BRAKETS: array[0..6] of array[0..5] of Char = (
    (' ', ' ', ' ', ' ', ' ', ' '),
    ('(', ' ', ')', ' ', ' ', ' '),
    (' ', '(', ' ', ' ', ')', ' '),
    (' ', ' ', ' ', '(', ' ', ')'),
    ('(', ' ', ' ', ' ', ')', ' '),
    (' ', '(', ' ', ' ', ' ', ')'),
    ('(', ' ', ')', '(', ' ', ')')
  );


function EvalSimpleExpression(const Value: string): Double;
var
  Code, Temp: string;
  Loop, APos: Integer;
  Opers, Consts: TStrings; // 操作符 // 操作数
  AFlag: Boolean; // 标志上一个有用的字符是否是操作符
begin
  Result:= 0;
  AFlag:= True;
  Opers:= TStringList.Create;
  Consts:= TStringList.Create;

  try
    Code:= UpperCase(Trim(Value)); // 取公式

    while Trim(Code) <> '' do
      case Code[1] of
        '+', '-', '*', '/', '^': // 如果是操作符
          begin
            if not AFlag then
            begin
              Opers.Add(Code[1]);
              Delete(Code, 1, 1);
              Temp:= '';
              AFlag:= True; // 添加了操作符以后，置标志为True
            end
            else
            begin
              Temp:= Code[1];
              Delete(Code, 1, 1);
              AFlag:= False; // 否则置标志为False
            end;
          end;

        '0'..'9', '.': // 如果是操作数
          begin
            while Trim(Code) <> '' do
              if Code[1] in ['0'..'9', '.'] then
              begin
                Temp:= Temp + Code[1];
                Delete(Code, 1, 1);
              end
              else
                Break;
                
            Consts.Add(Temp);
            AFlag:= False; // 添加了操作数以后置标志为False
          end;

        '(':       // 如果带括号
          begin
            Delete(Code, 1, 1);  // 删除第一个左括号
            APos:= 1;            // 括号配对数，正数为找到的左括号比右括号多
            Temp:= '';
            while Trim(Code) <> '' do
              if (Pos(')', Code) > -1) and (APos > 0) then
              begin
                if Code[1] = '(' then // 如果找到的是左括号则记数加一
                  Inc(APos)
                else if Code[1] = ')' then // 如果找到右括号则记数减一
                  Dec(APos);

                Temp:= Temp + Code[1];
                Delete(Code, 1, 1);
              end
              else
                Break;

            Temp:= Copy(Temp, 1, Length(Temp) - 1); // 删除最后一个右括号
            Consts.Add(FloatToStr(EvalSimpleExpression(Temp))); // 递归调用函数本身优先计算括号内的值
            Temp:= '';
            AFlag:= False; // 添加括号以后置标志为False
          end;

        else // 忽略其它字符
          Delete(Code, 1, 1);
      end;

    if Opers.Count = 0 then // 如果没有操作符
    begin
      if Consts.Count > 0 then // 如果有操作数
        Result:= StrToFloat(Consts.Strings[0]);
      Exit;
    end
    else if Consts.Count = 0 then // 如果没有操作数
      Exit;

    Loop:= 0;
    while Opers.Count > 0 do
    begin
      if Opers.Strings[Loop] = '^' then // 如果操作符是乘方
      begin
        Consts.Strings[Loop]:= FloatToStr(Power(StrToFloat(Consts.Strings[Loop]), StrToFloat(Consts.Strings[Loop + 1])));
        Consts.Delete(Loop + 1);
        Opers.Delete(Loop);
        Loop:= 0;
      end
      else if Opers.IndexOf('^') > -1 then // 如果不是次方但是还有计算次方操作符
      begin
        Inc(Loop);
        Continue;
      end
      else if Opers.Strings[Loop][1] in ['*', '/'] then // 如果是乘/除法
        case Opers.Strings[Loop][1] of
          '*':
            begin
              Consts.Strings[Loop]:= FloatToStr(StrToFloat(Consts.Strings[Loop]) * StrToFloat(Consts.Strings[Loop + 1]));
              Consts.Delete(Loop + 1);
              Opers.Delete(Loop);
              Loop:= 0;
            end;

          '/':
            begin
              Consts.Strings[Loop]:= FloatToStr(StrToFloat(Consts.Strings[Loop]) / StrToFloat(Consts.Strings[Loop + 1]));
              Consts.Delete(Loop + 1);
              Opers.Delete(Loop);
              Loop:= 0;
            end;
        end
      else if (Opers.IndexOf('*') > -1) or (Opers.IndexOf('/') > -1) then
      begin
        Inc(Loop);
        Continue;
      end
      else if Opers.Strings[Loop][1] in ['+', '-'] then
        case Opers.Strings[Loop][1] of
          '+':
            begin
              Consts.Strings[Loop]:= FloatToStr(StrToFloat(Consts.Strings[Loop])
                + StrToFloat(Consts.Strings[Loop + 1]));
              Consts.Delete(Loop + 1);
              Opers.Delete(Loop);
              Loop:= 0;
            end;

          '-':
            begin
              Consts.Strings[Loop]:= FloatToStr(StrToFloat(Consts.Strings[Loop])
                - StrToFloat(Consts.Strings[Loop + 1]));
              Consts.Delete(Loop + 1);
              Opers.Delete(Loop);
              Loop:= 0;
            end;
        end
      else
        Inc(Loop);
    end;

    Result:= StrToFloat(Consts.Strings[0]);
  finally
    FreeAndNil(Consts);
    FreeAndNil(Opers);
  end;
end;

function Calc24(A, B, C, D: Integer): string;
var
  I, J, K: Integer;
  Factors: array[0..3] of Integer;
  Expr: string;
begin
  Result := '';

  // 四个数有 24 种排列，每种排列的三个空有 64 种运算符填法，每种填法有 7 种括号组合方式
  // 利用穷举，每组数字需要最多 24*64*7 次才能算出可用结果，如果一万组，则最多需要计算 107520000 次
  for I := Low(SUB_FIXES) to High(SUB_FIXES) do
  begin
    Factors[SUB_FIXES[I][0]] := A;
    Factors[SUB_FIXES[I][1]] := B;
    Factors[SUB_FIXES[I][2]] := C;
    Factors[SUB_FIXES[I][3]] := D;

    // Factors 得到 24 个排列之一
    // Result := Result + Format('%d %d %d %d'#13#10,
    //  [Factors[0], Factors[1], Factors[2], Factors[3]]);
    for J := Low(OPERATORS) to High(OPERATORS) do
    begin
      for K := Low(BRAKETS) to High(BRAKETS) do
      begin
        Expr := Format('%s %d %s %s %d %s %s %s %d %s %s %d %s', [
          BRAKETS[K][0], Factors[0], OPERATORS[J][0],
          BRAKETS[K][1], Factors[1], BRAKETS[K][2], OPERATORS[J][1],
          BRAKETS[K][3], Factors[2], BRAKETS[K][4], OPERATORS[J][2],
          Factors[3], BRAKETS[K][5]]);

        try
          if Abs(EvalSimpleExpression(Expr) - 24) < 0.0000001 then
          begin
            Result := StringReplace(Expr, ' ', '', [rfReplaceAll]);
            Exit;
          end;
        except
          Continue;
        end;
      end;
    end;
  end;
end;

procedure TFormCalc.btnCalcClick(Sender: TObject);
var
  A, B, C, D: Integer;
  S: string;
begin
  A := StrToInt(edt1.Text);
  B := StrToInt(edt2.Text);
  C := StrToInt(edt3.Text);
  D := StrToInt(edt4.Text);

  mmoResult.Clear;
  S := Calc24(A, B, C, D);
  if Trim(S) = '' then
    mmoResult.Lines.Add('四则运算范围内无解')
  else
    mmoResult.Lines.Add(Calc24(A, B, C, D));
end;

procedure TFormCalc.btnListClick(Sender: TObject);
var
  A, B, C, D: Integer;
  S: string;
begin
  if FRunning then
  begin
    FRunning := False;
    Exit;
  end;
  FRunning := True;
  btnList.Caption := 'Stop';

  mmoList.Clear;
  Screen.Cursor := crHourGlass;
  try
    for A := 0 to 13 do
      for B := 0 to 13 do
        for C := 0 to 13 do
          for D := 0 to 13 do
          begin
            S := Calc24(A, B, C, D);
            if Trim(S) <> '' then
              mmoList.Lines.Add(Format('%d %d %d %d : %s', [A, B, C, D, S]))
            else
              mmoList.Lines.Add(Format('%d %d %d %d : 四则运算范围内无解', [A, B, C, D]));

            Application.ProcessMessages;
            if not FRunning then
            begin
              btnList.Caption := 'Calculate 24 for All';
              Exit;
            end;
          end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TFormCalc.btnSaveClick(Sender: TObject);
begin
  if dlgSave.Execute then
    mmoList.Lines.SaveToFile(dlgSave.FileName);
end;

end.
