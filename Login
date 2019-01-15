public class Perfil extends Fragment implements View.OnClickListener{

    private final Fragment activity = Perfil.this;

    private NestedScrollView nestedScrollView;
    private TextInputLayout textInputLayoutEmail;
    private TextInputLayout textInputLayoutPassword;
    private TextInputEditText textInputEditTextEmail;
    private TextInputEditText textInputEditTextPassword;
    private AppCompatButton appCompatButtonLogin;
    private AppCompatTextView textViewLinkRegister;
    private InputValidation inputValidation;
    private SQLite_OpenHelper databaseHelper;

    public Perfil() {
        // Required empty public constructor
    }


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        final View vista = inflater.inflate(R.layout.fragment_perfil, container, false);


        nestedScrollView = vista.findViewById(R.id.nestedScrollView);
        textInputLayoutEmail = vista.findViewById(R.id.textInputLayoutEmail);
        textInputLayoutPassword = vista.findViewById(R.id.textInputLayoutPassword);
        textInputEditTextEmail = vista.findViewById(R.id.textInputEditTextEmail);
        textInputEditTextPassword = vista.findViewById(R.id.textInputEditTextPassword);
        appCompatButtonLogin = vista.findViewById(R.id.appCompatButtonLogin);
        textViewLinkRegister = vista.findViewById(R.id.textViewLinkRegister);


            initListeners();
            initObjects();

            return vista;
        }

        /**
         * This method is to initialize listeners
         */
        private void initListeners() {
            appCompatButtonLogin.setOnClickListener(this);
            textViewLinkRegister.setOnClickListener(this);
        }

        /**
         * This method is to initialize objects to be used
         */
        private void initObjects() {
            databaseHelper = new SQLite_OpenHelper(getActivity());
            inputValidation = new InputValidation(getActivity());

        }

        /**
         * This implemented method is to listen the click on view
         *
         * @param v
         */
        @Override
        public void onClick(View v) {
            switch (v.getId()) {
                case R.id.appCompatButtonLogin:
                    verifyFromSQLite();
                    break;
                case R.id.textViewLinkRegister:
                    // Navigate to RegisterActivity
                    FragmentManager fm = getFragmentManager();
                    FragmentTransaction ft = fm.beginTransaction();
                    Registrar llf = new Registrar();
                    ft.replace(R.id.contenedor, llf);
                    ft.commit();
                    break;
            }
        }

        /**
         * This method is to validate the input text fields and verify login credentials from SQLite
         */
        private void verifyFromSQLite() {
            if (!inputValidation.isInputEditTextFilled(textInputEditTextEmail, textInputLayoutEmail, getString(R.string.error_message_email))) {
                return;
            }
            if (!inputValidation.isInputEditTextEmail(textInputEditTextEmail, textInputLayoutEmail, getString(R.string.error_message_email))) {
                return;
            }
            if (!inputValidation.isInputEditTextFilled(textInputEditTextPassword, textInputLayoutPassword, getString(R.string.error_message_password))) {
                return;
            }

            if (databaseHelper.checkUser(textInputEditTextEmail.getText().toString().trim()
                    , textInputEditTextPassword.getText().toString().trim())) {

                FragmentManager fm = getFragmentManager();
                FragmentTransaction ft = fm.beginTransaction();
                InicioSesion llf2 = new InicioSesion();
                ft.replace(R.id.contenedor, llf2);
                emptyInputEditText();
                ft.commit();

                /**Intent accountsIntent = new Intent(activity, InicioSesion.class);
                accountsIntent.putExtra("EMAIL", textInputEditTextEmail.getText().toString().trim());
                emptyInputEditText();
                startActivity(accountsIntent);

                */
            } else {
                // Snack Bar to show success message that record is wrong
                Snackbar.make(nestedScrollView, getString(R.string.error_valid_email_password), Snackbar.LENGTH_LONG).show();
            }
        }

        /**
         * This method is to empty all input edit text
         */
        private void emptyInputEditText() {
            textInputEditTextEmail.setText(null);
            textInputEditTextPassword.setText(null);
        }
    }
