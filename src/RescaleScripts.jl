module RescaleScripts

using ReadWriteFind, Printf

function generate_cli_script(job_name, analysis_type, analysis_version, core_type, number_of_cores, wall_time, port_number, license_server, remote_working_directory, model_names, local_working_directory, bash_filename, cpus, num_tokens)

    lines = []

    push!(lines, "#!/bin/bash")

    line = @sprintf """#RESCALE_NAME="%s\"""" job_name
    push!(lines, line)
    
    line = @sprintf "#RESCALE_ANALYSIS=%s" analysis_type
    push!(lines, line)

    line = @sprintf "#RESCALE_ANALYSIS_VERSION=%s" analysis_version
    push!(lines, line)

    line = @sprintf "#RESCALE_USER_DEFINED_LICENSE_SETTINGS={\"featureSets\":[{\"name\":\"USER_SPECIFIED\",\"features\":[{\"name\":\"abaqus\",\"count\":%d}]}]}}]}" num_tokens
    push!(lines, line)

    line = @sprintf "#RESCALE_CORE_TYPE=%s" core_type
    push!(lines, line)

    line = @sprintf "#RESCALE_CORES=%i" number_of_cores
    push!(lines, line)

    line = @sprintf "#RESCALE_WALLTIME=%s" wall_time
    push!(lines, line)

    line = @sprintf "#RESCALE_ENV_LM_LICENSE_FILE=%i@%s" port_number license_server 
    push!(lines, line)

    line = @sprintf "cd %s" remote_working_directory
    push!(lines, line)

    for i in eachindex(model_names)
        line = "abaqus job=" * model_names[i] * " cpus=$cpus" * " interactive"
        push!(lines, line)
    end

    ReadWriteFind.write_file(joinpath(local_working_directory, bash_filename), lines)


end



function generate_cli_script(job_name, analysis_type, analysis_version, core_type, number_of_cores, wall_time, port_number, license_server, remote_working_directory, model_names, local_working_directory, bash_filename, cpus, uel_filename, num_tokens)

    lines = []

    push!(lines, "#!/bin/bash")

    line = @sprintf """#RESCALE_NAME="%s\"""" job_name
    push!(lines, line)
    
    line = @sprintf "#RESCALE_ANALYSIS=%s" analysis_type
    push!(lines, line)

    line = @sprintf "#RESCALE_ANALYSIS_VERSION=%s" analysis_version
    push!(lines, line)

    line = @sprintf "#RESCALE_USER_DEFINED_LICENSE_SETTINGS={\"featureSets\":[{\"name\":\"USER_SPECIFIED\",\"features\":[{\"name\":\"abaqus\",\"count\":%d}]}]}}]}" num_tokens
    push!(lines, line)

    line = @sprintf "#RESCALE_CORE_TYPE=%s" core_type
    push!(lines, line)

    line = @sprintf "#RESCALE_CORES=%i" number_of_cores
    push!(lines, line)

    line = @sprintf "#RESCALE_WALLTIME=%s" wall_time
    push!(lines, line)

    line = @sprintf "#RESCALE_ENV_LM_LICENSE_FILE=%i@%s" port_number license_server 
    push!(lines, line)

    line = @sprintf "cd %s" remote_working_directory
    push!(lines, line)

    for i in eachindex(model_names)
        line = "abaqus job=" * model_names[i] * " user=" * uel_filename * " cpus=$cpus" * " interactive" 
        push!(lines, line)
    end

    ReadWriteFind.write_file(joinpath(local_working_directory, bash_filename), lines)


end


end # module RescaleScripts
