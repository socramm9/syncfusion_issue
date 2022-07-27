import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_issue/grid/enployee.dart';

class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource({required List<Employee> employees}) {
    dataGridRows = employees
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: dataGridRow.id),
              DataGridCell<String>(columnName: 'name', value: dataGridRow.name),
              DataGridCell<String>(
                  columnName: 'designation', value: dataGridRow.designation),
              DataGridCell<int>(
                  columnName: 'salary', value: dataGridRow.salary),
            ]))
        .toList();
  }

  int? rightClickRowId;
  int? rightClickRowIndex;

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    final id = row
        .getCells()
        .firstWhere(
          (element) => element.columnName == "id",
        )
        .value as int;

    final rowColor = id == rightClickRowId
        ? Colors.red.withOpacity(0.2)
        : Colors.transparent;

    print("$id $rowColor");

    return DataGridRowAdapter(
        color: rowColor,
        cells: row.getCells().map<Widget>((dataGridCell) {
          return Container(
            alignment: (dataGridCell.columnName == 'id' ||
                    dataGridCell.columnName == 'salary')
                ? Alignment.centerRight
                : Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              dataGridCell.value.toString(),
              overflow: TextOverflow.ellipsis,
            ),
          );
        }).toList());
  }

  void clearRightClick() {
    if (rightClickRowId != null) {
      final rowIndex = rightClickRowIndex;
      rightClickRowIndex = null;
      rightClickRowId = null;
      notifyDataSourceListeners(rowColumnIndex: RowColumnIndex(rowIndex!, 0));
    }
  }

  void setRowRightClicked(int rowIndex, int rowId) {
    clearRightClick();
    rightClickRowIndex = rowIndex;
    rightClickRowId = rowId;
    notifyDataSourceListeners(rowColumnIndex: RowColumnIndex(rowIndex, 0));
  }
}
