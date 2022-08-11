// testu_comp.pas

// la fiche de test du composant
unit tstu_comp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, PP_PasswordDlg;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Edit1: TEdit;
    pwd: TPPPasswordDlg;
    Label2: TLabel;
    Edit2: TEdit;
    procedure Button1Click(Sender: TObject);
    function pwdGetPassword(User: String): String;
    function pwdSetPassword(User, NewPassword: String): Boolean;
  private
    { Déclarations privées }
    password : string;
  public
    { Déclarations publiques }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
begin
  password := Edit1.Text;
  pwd.DefaultUser := Edit2.Text;
  if pwd.execute
  then
    ShowMessage ('OK')
  else
    ShowMessage ('NOK');
  {endif}
end;

function TForm1.pwdGetPassword(User: String): String;
begin
  Result := password;
end;

function TForm1.pwdSetPassword(User, NewPassword: String): Boolean;
begin
  password := NewPassword;
  Edit1.Text := password;
  Result := True;
end;

end.
