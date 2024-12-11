import 'package:flutter/material.dart';

class EventDetailsPage extends StatelessWidget {
  final String eventName;
  final String eventDate;
  final String eventLocation;
  final String eventDescription;

  const EventDetailsPage({
    Key? key,
    required this.eventName,
    required this.eventDate,
    required this.eventLocation,
    required this.eventDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(eventName, style: const TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              eventName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Data: $eventDate', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Local: $eventLocation', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            Text(
              eventDescription,
              style: const TextStyle(fontSize: 16),
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegistrationForm(eventName: eventName),
                  ),
                );
              },
              child: const Text('Fazer Inscrição', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}

class RegistrationForm extends StatelessWidget {
  final String eventName;

  const RegistrationForm({Key? key, required this.eventName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController cpfController = TextEditingController();
    final TextEditingController healthIssuesController =
        TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFFECEFF1), // Fundo cinza claro
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF9800), // Laranja
        title: Text(
          'Inscrição para $eventName',
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              _buildTextField('Nome Completo', nameController),
              const SizedBox(height: 16),
              _buildTextField('Email', emailController, isEmail: true),
              const SizedBox(height: 16),
              _buildTextField('Telefone', phoneController, isPhone: true),
              const SizedBox(height: 16),
              _buildTextField('CPF', cpfController, isNumeric: true),
              const SizedBox(height: 16),
              _buildTextField(
                'Possui algum problema de saúde?',
                healthIssuesController,
                maxLines: 4,
                hintText: 'Ex.: Pneumonia, Asma, etc...',
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancelar'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF9800),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () {
                        _submitForm(
                          nameController.text,
                          emailController.text,
                          phoneController.text,
                          cpfController.text,
                          healthIssuesController.text,
                          context,
                        );
                      },
                      child: const Text('Concluir'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool isEmail = false, bool isPhone = false, bool isNumeric = false, int maxLines = 1, String? hintText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: isEmail
              ? TextInputType.emailAddress
              : isPhone
                  ? TextInputType.phone
                  : isNumeric
                      ? TextInputType.number
                      : TextInputType.text,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText ?? 'Digite $label',
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          ),
        ),
      ],
    );
  }

  void _submitForm(
    String name,
    String email,
    String phone,
    String cpf,
    String healthIssues,
    BuildContext context,
  ) {
    if (name.isEmpty || email.isEmpty || phone.isEmpty || cpf.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, preencha todos os campos obrigatórios.')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Inscrição realizada com sucesso!')),
    );

    Navigator.pop(context);
  }
}
