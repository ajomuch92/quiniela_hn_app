import 'package:flutter/material.dart';
import 'package:flutter_solidart/flutter_solidart.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:quiniela_hn_app/models/Group.dart';

class HomeList extends StatelessWidget {
  final Resource<List<Group>> resourceGroup;
  final Function(bool)? onChange;
  final Signal isChecked = Signal(false);
  HomeList({super.key, required this.resourceGroup, this.onChange});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Bienvenido',
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.left,
        ),
        SignalBuilder(
            signal: isChecked,
            builder: (context, value, child) {
              return GFCheckboxListTile(
                titleText: 'Mostrarme solo los grupos creados por mí',
                position: GFPosition.start,
                size: GFSize.SMALL,
                activeBgColor: GFColors.PRIMARY,
                type: GFCheckboxType.circle,
                onChanged: (newValue) {
                  isChecked.value = newValue;
                  onChange!(newValue);
                },
                value: value,
              );
            }),
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
                            'No tienes grupos creados o asignados',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text('Intenta crear uno para comenzar'),
                        ],
                      );
                    }
                    return ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          Group group = data[index];
                          return Card(
                            child: ListTile(
                              title: Text(group.name!),
                              subtitle: Text(
                                  'Creado en ${DateFormat('dd/MM/yyyy').format(DateFormat('yyyy-MM-dd').parse(group.created))}'),
                              leading: const Icon(Icons.sports_soccer_sharp),
                            ),
                          );
                        },
                        separatorBuilder: (context, _) => const Divider(),
                        itemCount: data.length);
                  },
                  error: (error, _) =>
                      const Text('Hubo un error al cargar los grupos'),
                  loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ));
            })
      ],
    );
  }
}
