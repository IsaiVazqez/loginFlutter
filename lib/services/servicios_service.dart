import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login/models/models.dart';
import 'package:http/http.dart' as http;

class ServicioService extends ChangeNotifier {
  final String _baseUrl = 'flutter-varios-87503-default-rtdb.firebaseio.com';

  final List<Servicio> servicio = [];
  bool isLoading = true;
  bool isSaving = false;
  late Servicio selectedServicio;

  ServicioService() {
    this.loadServicios();
  }

  Future<List<Servicio>> loadServicios() async {
    this.isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, 'products.json');
    final resp = await http.get(url);

    final Map<String, dynamic> serviciosMap = json.decode(resp.body);

    serviciosMap.forEach((key, value) {
      final tempServicio = Servicio.fromMap(value);
      tempServicio.id = key;
      this.servicio.add(tempServicio);
    });

    this.isLoading = false;

    notifyListeners();

    return this.servicio;
  }

  Future saveOrCreateServicio(Servicio servicio) async {
    isSaving = true;
    notifyListeners();

    if (servicio.id == null) {
      await this.createProduct(servicio);
    } else {
      await this.updateServicio(servicio);
    }
    isSaving = false;
    notifyListeners();
  }

  Future<String> updateServicio(Servicio servicio) async {
    final url = Uri.https(_baseUrl, 'products/${servicio.id}.json');
    final resp = await http.put(url, body: servicio.toJson());
    final decodedData = resp.body;

    final index =
        this.servicio.indexWhere((element) => element.id == servicio.id);
    this.servicio[index] = servicio;

    return servicio.id!;
  }

  Future<String> createProduct(Servicio servicio) async {
    final url = Uri.https(_baseUrl, 'products.json');
    final resp = await http.post(url, body: servicio.toJson());
    final decodedData = json.decode(resp.body);

    servicio.id = decodedData['name'];

    this.servicio.add(servicio);

    return servicio.id!;
  }
}
