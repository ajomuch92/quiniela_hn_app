import 'package:flutter/material.dart';
import 'package:flutter_solidart/flutter_solidart.dart';
import 'package:intl/intl.dart';
import 'package:quiniela_hn_app/models/Tournament.dart';

class HomeList extends StatelessWidget {
  final Resource<List<Tournament>> resourceGroup;
  final Signal isChecked = Signal(false);
  HomeList({super.key, required this.resourceGroup});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Bienvenido',
          style: TextStyle(fontSize: 24),
          textAlign: TextAlign.left,
        ),
        const Text(
          'Puedes escoger uno de los torneos activos para jugar con tus amigos.',
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.left,
        ),
        const SizedBox(
          height: 20,
        ),
        ResourceBuilder(
            resource: resourceGroup,
            builder: (context, state) {
              return state.on(
                  ready: (data) {
                    if (data.isEmpty) {
                      return const Column(
                        children: [
                          Text(
                            'No hay torneos activos en juego',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      );
                    } else if (state.isRefreshing) {
                      return const LinearProgressIndicator();
                    }
                    return ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          Tournament tournament = data[index];
                          return Card(
                            child: ListTile(
                              title: Text(tournament.name!),
                              subtitle: Text(
                                  'Creado en ${DateFormat('dd/MM/yyyy').format(DateFormat('yyyy-MM-dd').parse(tournament.created))}'),
                              leading: const Icon(Icons.sports_soccer_sharp),
                            ),
                          );
                        },
                        separatorBuilder: (context, _) => const Divider(),
                        itemCount: data.length);
                  },
                  error: (error, _) =>
                      const Text('Hubo un error al cargar los torneos 😅'),
                  loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ));
            })
      ],
    );
  }
}
