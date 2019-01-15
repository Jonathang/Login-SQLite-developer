public class Registrar extends Fragment implements View.OnClickListener {

    private final Fragment activity = Registrar.this;

    private NestedScrollView nestedScrollView;

    private TextInputLayout textInputLayoutName;
    private TextInputLayout textInputLayoutEmail;
    private TextInputLayout textInputLayoutPassword;
    private TextInputLayout textInputLayoutConfirmPassword;

    private TextInputEditText textInputEditTextName;
    private TextInputEditText textInputEditTextEmail;
    private TextInputEditText textInputEditTextPassword;
    private TextInputEditText textInputEditTextConfirmPassword;

    private AppCompatButton appCompatButtonRegister;
    private AppCompatTextView appCompatTextViewLoginLink;

    private InputValidation inputValidation;
    private SQLite_OpenHelper databaseHelper;
    private Model user;

    public Registrar() {
        // Required empty public constructor
    }


    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View vista = inflater.inflate(R.layout.fragment_registrar, container, false);

        nestedScrollView = vista.findViewById(R.id.nestedScrollView);

        textInputLayoutName = vista.findViewById(R.id.textInputLayoutName);
        textInputLayoutEmail = vista.findViewById(R.id.textInputLayoutEmail);
        textInputLayoutPassword = vista.findViewById(R.id.textInputLayoutPassword);
        textInputLayoutConfirmPassword = vista.findViewById(R.id.textInputLayoutConfirmPassword);
        textInputEditTextName = vista.findViewById(R.id.textInputEditTextName);
        textInputEditTextEmail = vista.findViewById(R.id.textInputEditTextEmail);
        textInputEditTextPassword = vista.findViewById(R.id.textInputEditTextPassword);
        textInputEditTextConfirmPassword = vista.findViewById(R.id.textInputEditTextConfirmPassword);
        appCompatButtonRegister = vista.findViewById(R.id.appCompatButtonRegister);
        appCompatTextViewLoginLink = vista.findViewById(R.id.appCompatTextViewLoginLink);


        initListeners();
        initObjects();

        return vista;
    }
        private void initListeners() {
            appCompatButtonRegister.setOnClickListener(this);
            appCompatTextViewLoginLink.setOnClickListener(this);

        }

        /**
         * This method is to initialize objects to be used
         */
        private void initObjects() {
            inputValidation = new InputValidation(getActivity());
            databaseHelper = new SQLite_OpenHelper(getActivity());
            user = new Model();

        }


        /**
         * This implemented method is to listen the click on view
         *
         * @param v
         */
        @Override
        public void onClick(View v) {
            switch (v.getId()) {

                case R.id.appCompatButtonRegister:
                    postDataToSQLite();
                    break;

                case R.id.appCompatTextViewLoginLink:
                    FragmentManager fm = getFragmentManager();
                    FragmentTransaction ft = fm.beginTransaction();
                    Perfil llf = new Perfil();
                    ft.replace(R.id.contenedor, llf);
                    ft.commit();
                    break;
            }
        }

        /**
         * This method is to validate the input text fields and post data to SQLite
         */
        private void postDataToSQLite() {
            if (!inputValidation.isInputEditTextFilled(textInputEditTextName, textInputLayoutName, getString(R.string.error_message_name))) {
                return;
            }
            if (!inputValidation.isInputEditTextFilled(textInputEditTextEmail, textInputLayoutEmail, getString(R.string.error_message_email))) {
                return;
            }
            if (!inputValidation.isInputEditTextEmail(textInputEditTextEmail, textInputLayoutEmail, getString(R.string.error_message_email))) {
                return;
            }
            if (!inputValidation.isInputEditTextFilled(textInputEditTextPassword, textInputLayoutPassword, getString(R.string.error_message_password))) {
                return;
            }
            if (!inputValidation.isInputEditTextMatches(textInputEditTextPassword, textInputEditTextConfirmPassword,
                    textInputLayoutConfirmPassword, getString(R.string.error_password_match))) {
                return;
            }

            if (!databaseHelper.checkUser(textInputEditTextEmail.getText().toString().trim())) {

                user.setNombre(textInputEditTextName.getText().toString().trim());
                user.setCorreo(textInputEditTextEmail.getText().toString().trim());
                user.setPassword(textInputEditTextPassword.getText().toString().trim());

                FragmentManager fm = getFragmentManager();
                FragmentTransaction ft = fm.beginTransaction();
                Perfil llf = new Perfil();
                ft.replace(R.id.contenedor, llf);
                ft.commit();

                databaseHelper.addUser(user);

                // Snack Bar to show success message that record saved successfully
                Snackbar.make(nestedScrollView, getString(R.string.success_message), Snackbar.LENGTH_LONG).show();
                emptyInputEditText();


            } else {
                // Snack Bar to show error message that record already exists
                Snackbar.make(nestedScrollView, getString(R.string.error_email_exists), Snackbar.LENGTH_LONG).show();
            }


        }

        /**
         * This method is to empty all input edit text
         */
        private void emptyInputEditText() {
            textInputEditTextName.setText(null);
            textInputEditTextEmail.setText(null);
            textInputEditTextPassword.setText(null);
            textInputEditTextConfirmPassword.setText(null);
        }
    }
