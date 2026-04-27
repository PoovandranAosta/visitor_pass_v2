// import 'package:flutter/material.dart';
//
// class ReusableLoginWidget extends StatefulWidget {
//   // Controllers
//   final TextEditingController usernameController;
//   final TextEditingController passwordController;
//
//   // Callback
//   final Function(String role, String username, String password) onLogin;
//
//   // Customization
//   final String adminLabel;
//   final String securityLabel;
//   final String usernameHint;
//   final String passwordHint;
//   final String buttonText;
//
//   final Color primaryColor;
//   final Color backgroundColor;
//   final Color buttonColor;
//   final Color textColor;
//
//   final double borderRadius;
//   final double width;
//   final EdgeInsets padding;
//
//   const ReusableLoginWidget({
//     super.key,
//     required this.usernameController,
//     required this.passwordController,
//     required this.onLogin,
//     this.adminLabel = "Admin",
//     this.securityLabel = "Security",
//     this.usernameHint = "Enter Username",
//     this.passwordHint = "Enter Password",
//     this.buttonText = "Sign In",
//     this.primaryColor = Colors.blue,
//     this.backgroundColor = Colors.white,
//     this.buttonColor = Colors.blue,
//     this.textColor = Colors.black,
//     this.borderRadius = 12,
//     this.width = 400,
//     this.padding = const EdgeInsets.all(24),
//   });
//
//   @override
//   State<ReusableLoginWidget> createState() => _ReusableLoginWidgetState();
// }
//
// class _ReusableLoginWidgetState extends State<ReusableLoginWidget> {
//   String selectedRole = "Admin";
//   bool obscurePassword = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Container(
//         width: widget.width,
//         padding: widget.padding,
//         decoration: BoxDecoration(
//           color: widget.backgroundColor,
//           borderRadius: BorderRadius.circular(widget.borderRadius),
//           boxShadow: [
//             BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 2),
//           ],
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             /// Role Toggle
//             // Container(
//             //   decoration: BoxDecoration(
//             //     color: widget.primaryColor.withOpacity(0.1),
//             //     borderRadius: BorderRadius.circular(widget.borderRadius),
//             //   ),
//             //   child: Row(
//             //     children: [
//             //       _buildRoleButton(widget.adminLabel),
//             //       _buildRoleButton(widget.securityLabel),
//             //     ],
//             //   ),
//             // ),
//             //
//             // const SizedBox(height: 20),
//
//             Column(
//               children: [
//                 Icon(
//                   Icons.lock_outline,
//                   size: 50,
//                   color: widget.primaryColor,
//                 ),
//                 const SizedBox(height: 10),
//                 Text(
//                   "Login",
//                   style: TextStyle(
//                     fontSize: 28,
//                     fontWeight: FontWeight.w600,
//                     color: widget.primaryColor,
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//               ],
//             ),
//
//             /// Username Field
//             TextField(
//               controller: widget.usernameController,
//               decoration: InputDecoration(
//                 hintText: widget.usernameHint,
//                 prefixIcon: const Icon(Icons.person),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(widget.borderRadius),
//                 ),
//               ),
//             ),
//
//             const SizedBox(height: 16),
//
//             /// Password Field
//             TextField(
//               controller: widget.passwordController,
//               obscureText: obscurePassword,
//               decoration: InputDecoration(
//                 hintText: widget.passwordHint,
//                 prefixIcon: const Icon(Icons.lock),
//                 suffixIcon: IconButton(
//                   icon: Icon(
//                     obscurePassword ? Icons.visibility_off : Icons.visibility,
//                   ),
//                   onPressed: () {
//                     setState(() {
//                       obscurePassword = !obscurePassword;
//                     });
//                   },
//                 ),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(widget.borderRadius),
//                 ),
//               ),
//             ),
//
//             const SizedBox(height: 24),
//
//             /// Sign In Button
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: widget.buttonColor,
//                   padding: const EdgeInsets.symmetric(vertical: 14),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(widget.borderRadius),
//                   ),
//                 ),
//                 onPressed: () {
//                   widget.onLogin(
//                     selectedRole,
//                     widget.usernameController.text.trim(),
//                     widget.passwordController.text.trim(),
//                   );
//                 },
//                 child: Text(
//                   widget.buttonText,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildRoleButton(String role) {
//     final isSelected = selectedRole == role;
//
//     return Expanded(
//       child: GestureDetector(
//         onTap: () {
//           setState(() {
//             selectedRole = role;
//           });
//         },
//         child: Container(
//           padding: const EdgeInsets.symmetric(vertical: 12),
//           decoration: BoxDecoration(
//             color: isSelected ? widget.primaryColor : Colors.transparent,
//             borderRadius: BorderRadius.circular(widget.borderRadius),
//           ),
//           child: Center(
//             child: Text(
//               role,
//               style: TextStyle(
//                 color: isSelected ? Colors.white : widget.textColor,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class CustomLogin extends StatefulWidget {
  // Controllers
  final TextEditingController usernameController;
  final TextEditingController passwordController;

  // Callback
  final Future<void> Function(
      String username,
      String password,
      ) onLogin;

  /// Loading State
  final bool isLoading;

  // Labels
  final String title;
  final String usernameHint;
  final String passwordHint;
  final String buttonText;

  // Validators (Optional)
  final String? Function(String?)? usernameValidator;
  final String? Function(String?)? passwordValidator;

  // Customization
  final Color primaryColor;
  final Color backgroundColor;
  final Color buttonColor;
  final Color textColor;
  final Color fieldFillColor;

  final double borderRadius;
  final double width;
  final EdgeInsets padding;
  final IconData topIcon;

  const CustomLogin({
    super.key,
    required this.usernameController,
    required this.passwordController,
    required this.onLogin,
    required this.isLoading,
    this.title = "Login",
    this.usernameHint = "Enter Username",
    this.passwordHint = "Enter Password",
    this.buttonText = "Sign In",
    this.primaryColor = Colors.blue,
    this.backgroundColor = Colors.white,
    this.buttonColor = Colors.blue,
    this.textColor = Colors.black,
    this.fieldFillColor = const Color(0xFFF5F5F5),
    this.borderRadius = 12,
    this.width = 400,
    this.padding = const EdgeInsets.all(24),
    this.topIcon = Icons.lock_outline,
    this.usernameValidator,
    this.passwordValidator,
  });

  @override
  State<CustomLogin> createState() =>
      _CustomLoginState();
}

class _CustomLoginState extends State<CustomLogin> {
  final _formKey = GlobalKey<FormState>();
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: widget.width,
        padding: widget.padding,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius:
          BorderRadius.circular(widget.borderRadius),
          boxShadow: const [
            BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                spreadRadius: 2),
          ],
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Top Icon + Title
              Icon(widget.topIcon,
                  size: 50, color: widget.primaryColor),
              const SizedBox(height: 10),
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  color: widget.primaryColor,
                ),
              ),
              const SizedBox(height: 20),

              /// Username
              TextFormField(
                controller: widget.usernameController,
                validator: widget.usernameValidator ??
                        (value) {
                      if (value == null ||
                          value.trim().isEmpty) {
                        return "Username is required";
                      }
                      return null;
                    },
                decoration: _inputDecoration(
                  hint: widget.usernameHint,
                  icon: Icons.person,
                ),
              ),

              const SizedBox(height: 16),

              /// Password
              TextFormField(
                controller: widget.passwordController,
                obscureText: obscurePassword,
                validator: widget.passwordValidator ??
                        (value) {
                      if (value == null ||
                          value.trim().isEmpty) {
                        return "Password is required";
                      }
                      return null;
                    },
                decoration: _inputDecoration(
                  hint: widget.passwordHint,
                  icon: Icons.lock,
                  suffix: IconButton(
                    icon: Icon(
                      obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        obscurePassword =
                        !obscurePassword;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 24),

              /// Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    widget.buttonColor,
                    padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                    minimumSize: const Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(
                          widget.borderRadius),
                    ),
                  ),
                  onPressed: widget.isLoading
                      ? null
                      : () async {
                    if (_formKey.currentState!
                        .validate()) {
                      await widget.onLogin(
                        widget
                            .usernameController
                            .text
                            .trim(),
                        widget
                            .passwordController
                            .text
                            .trim(),
                      );
                    }
                  },
                  child: widget.isLoading
                      ? const SizedBox(
                    height: 22,
                    width: 22,
                    child:
                    CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                      : Text(
                    widget.buttonText,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight:
                      FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
    Widget? suffix,
  }) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon),
      suffixIcon: suffix,
      filled: true,
      fillColor: widget.fieldFillColor,
      border: OutlineInputBorder(
        borderRadius:
        BorderRadius.circular(widget.borderRadius),
      ),
    );
  }
}