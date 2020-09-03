import os

import pandas as pd

# entire path to /Time
cwd = os.getcwd()

data_dir = cwd + "/Data/"
csv_dir = cwd + "/CSV/"

df = pd.DataFrame({'time': [], 'runs': [], 'requests': [], 'type': []})

# iterates through all files in the given folder
for subdir, dirs, files in os.walk(data_dir):

    time_list = []
    time_list_no_failed_runs = []

    # subdir name is always gonna be last element of path splitted by /
    subdir_name = (subdir.split("/"))[-1]
    file_save_name = subdir_name + ".csv"

    # skip initial empty run
    if subdir_name != "":

        # subirs are called like 100-1000-t
        subir_splitted = subdir_name.split("-")
        run_amount = subir_splitted[0]
        request_amount = subir_splitted[1]

        if subir_splitted[2] == "t":
            run_type = "Thread"
        else:
            run_type = "Virtual Thread"

        for file in files:

            # ignore .apps filex
            if file.endswith(".txt"):

                with open(os.path.join(subdir, file)) as foo:
                    lines = foo.readlines()
                    file_length = len(lines)
                    # check if file length == 43, if it is not 43, the run failed, ommit that run
                    if file_length >= 43:
                        time_taken_line = lines[15]
                        time_extracted = time_taken_line[24:-9]
                        time_list.append(time_extracted)
                        time_list_no_failed_runs.append(time_extracted)

        # check how many runs were succesful
        run_amount_list = [run_amount] * len(time_list)
        request_amount_list = [request_amount] * len(time_list)
        run_type_list = [run_type] * len(time_list)

        df_2 = pd.DataFrame(
            {'time': time_list, 'runs': run_amount, 'requests': request_amount_list, 'type': run_type_list})
        df = pd.concat([df, df_2])

df.to_csv(csv_dir + "all.csv", encoding="utf-8", index=True, index_label="run_number")
