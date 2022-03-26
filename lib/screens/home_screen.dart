import 'package:flutter/material.dart';
import 'package:login/models/models.dart';
import 'package:login/services/services.dart';
import 'package:login/widgets/widgets.dart';
import 'package:login/screens/screens.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final servicioService = Provider.of<ServicioService>(context);

    if (servicioService.isLoading) return LoadingScreen();

    return Scaffold(
      appBar: AppBar(title: Text('Servicios')),
      body: ListView.builder(
          itemCount: servicioService.servicio.length,
          itemBuilder: (BuildContext context, int index) => GestureDetector(
                onTap: () {
                  servicioService.selectedServicio =
                      servicioService.servicio[index].copy();
                  Navigator.pushNamed(context, 'servicio');
                },
                child: ServicioCard(
                  servicio: servicioService.servicio[index],
                ),
              )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          servicioService.selectedServicio = new Servicio(
              horario: '', discapacitados: false, name: '', personas: 0);
          Navigator.pushNamed(context, 'servicio');
        },
      ),
    );
  }
}
