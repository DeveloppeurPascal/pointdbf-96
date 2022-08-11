// TestPasswordDlgForm.dpr

// source du projet permettant de créer la fenêtre de dialogue de départ
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
