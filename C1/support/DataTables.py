from math import floor


class DataTables(object):
    def create_datatable(self, *cell_list):
        if not cell_list[0].startswith(':'):
            return self.create_datatable_from_dictionary_syntax(cell_list)
        header = [i[1:] for i in cell_list if i.startswith(':')]
        row_count = floor(len(cell_list) / len(header) - 1)
        result = []
        for r in range(row_count):
            row_cells = cell_list[len(header) * (r+1):len(header) * (r+2)]
            row = {}
            for i in range(len(header)):
                self.update_datatable_row(row, header[i], row_cells[i])
            result.append(row)
        return result

    def create_datatable_from_dictionary_syntax(self, cell_list):
        row = {}
        for cell in cell_list:
            parts = cell.split('=', 1)
            self.update_datatable_row(row, parts[0], parts[1])
        return [row]

    def create_datatable_row(self, *cell_list):
        table = self.create_datatable(*cell_list)
        return table[0]

    def get_datatable_value(self, table, row, key):
        return table[int(row)][key]

    def apply_datatable_defaults(self, table, default_item):
        for r in table:
            for k in default_item.keys():
                r.setdefault(k, default_item[k])

    def apply_datatable_row_defaults(self, row, default_item):
        for k in default_item.keys():
            row.setdefault(k, default_item[k])

    def update_datatable_row(self, row, key, value):
        row[key] = value if value != '<empty>' else ''
