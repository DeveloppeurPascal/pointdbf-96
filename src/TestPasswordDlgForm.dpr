// TestPasswordDlgForm.dpr

// source du projet permettant de cr�er la fen�tre de dialogue de d�part
program TestPasswordDlgForm;

uses
  Forms,
  PP_PasswordDlgForm in 'PP_PasswordDlgForm.pas' {PPPasswordDlgForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TPPPasswordDlgForm, PPPasswordDlgForm);
  Application.Run;
end.
