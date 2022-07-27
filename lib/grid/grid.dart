import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'package:syncfusion_issue/grid/enployee.dart';
import 'package:syncfusion_issue/grid/enployee_data_source.dart';

class Grid extends StatefulWidget {
  const Grid({Key? key}) : super(key: key);

  @override
  State<Grid> createState() => _GridState();
}

class _GridState extends State<Grid> {
  late EmployeeDataSource _source;

  List<Employee> _employees = <Employee>[];

  @override
  void initState() {
    super.initState();
    _employees = getEmployeeData();
    _source = EmployeeDataSource(employees: _employees);
  }

  List<Employee> getEmployeeData() {
    return [
      Employee(10001, 'James', 'Project Lead', 20000),
      Employee(10002, 'Kathryn', 'Manager', 30000),
      Employee(10003, 'Lara', 'Developer', 15000),
      Employee(10004, 'Michael', 'Designer', 15000),
      Employee(10005, 'Martin', 'Developer', 15000),
      Employee(10006, 'Newberry', 'Developer', 15000),
      Employee(10007, 'Balnc', 'Developer', 15000),
      Employee(10008, 'Perry', 'Developer', 15000),
      Employee(10009, 'Gable', 'Developer', 15000),
      Employee(10010, 'Grimes', 'Developer', 15000)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SfDataGrid(
      source: _source,
      columnWidthMode: ColumnWidthMode.fill,
      onCellSecondaryTap: (d) {
        final rowIndex = d.rowColumnIndex.rowIndex - 1;
        final row = _source.effectiveRows[rowIndex];
        final id = row
            .getCells()
            .firstWhere(
              (element) => element.columnName == "id",
            )
            .value as int;

        _source.setRowRightClicked(rowIndex, id);
      },
      columns: [
        GridColumn(
          columnName: 'id',
          label: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            alignment: Alignment.centerRight,
            child: const Text(
              'ID',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'name',
          label: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Name',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'designation',
          label: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Designation',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        GridColumn(
          columnName: 'salary',
          label: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            alignment: Alignment.centerRight,
            child: const Text(
              'Salary',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        )
      ],
    );
  }
}
