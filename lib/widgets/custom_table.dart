import 'package:flutter/material.dart';

class CustomDynamicTable extends StatelessWidget {
  final List<String> columns;
  final List<List<Widget>> rows;
  final Function(int index)? onDelete;
  final Color primaryColor;
  final bool showDelete;

  const CustomDynamicTable({
    super.key,
    required this.columns,
    required this.rows,
    this.onDelete,
    this.primaryColor = const Color(0xFF1976D2),
    this.showDelete = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            blurRadius: 14,
            color: Colors.black.withOpacity(.06),
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: 
      LayoutBuilder(builder: (context, constraints) {

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: constraints.maxWidth, // 👈 IMPORTANT
            ),
            child: DataTable(
              columnSpacing: 40,
              headingRowHeight: 52,
              dataRowMinHeight: 48,
              dataRowMaxHeight: 56,
              headingRowColor:
              WidgetStateProperty.all(primaryColor.withOpacity(.08)),
              columns: [
                ...columns.map(
                      (c) => DataColumn(
                    label: Text(
                      c,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                if (showDelete)
                  const DataColumn(
                    label: Text(
                      "Action",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
              ],
              rows: List.generate(rows.length, (index) {
                return DataRow(
                  color: WidgetStateProperty.resolveWith<Color?>(
                        (states) {
                      if (index.isEven) {
                        return Colors.grey.withOpacity(.04);
                      }
                      return null;
                    },
                  ),
                  cells: [
                    ...rows[index].map((e) => DataCell(e)).toList(),
                    if (showDelete)
                      DataCell(
                        InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: () => onDelete?.call(index),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.delete, color: Colors.red, size: 18),
                                SizedBox(width: 4),
                                Text(
                                  "Delete",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              }),
            ),
          ),
        );

      })
      

    );
  }
}