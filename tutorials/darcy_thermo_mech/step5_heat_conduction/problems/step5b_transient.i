[Mesh]
  type = GeneratedMesh
  dim = 2
  nx = 100
  ny = 10
  xmax = 0.304 # Length of test chamber
  ymax = 0.0257 # Test chamber radius
[]

[Variables]
  [./temp]
    initial_condition = 300 # Start at room temperature
  [../]
[]

[Kernels]
  [./heat_conduction]
    type = HeatConduction
    variable = temp
  [../]
  [./heat_conduction_time_derivative]
    type = HeatConductionTimeDerivative
    variable = temp
  [../]
[]

[BCs]
  [./inlet_temperature]
    type = DirichletBC
    variable = temp
    boundary = left
    value = 350 # (K)
  [../]
  [./outlet_temperature]
    type = DirichletBC
    variable = temp
    boundary = right
    value = 300 # (K)
  [../]
[]

[Materials]
  [./steel]
    type = GenericConstantMaterial
    block = 0
    prop_names = 'thermal_conductivity specific_heat density'
    prop_values = '18 0.466 8000' # K: W/m*K from wikipedia @296K, Cp: (J/kg*K) from wikipedia, rho: (kg/m^3) from wikipedia
  [../]
[]

[Problem]
  type = FEProblem
  coord_type = RZ
  rz_coord_axis = X
[]

[Executioner]
  type = Transient
  num_steps = 10
  solve_type = PJFNK
  petsc_options_iname = '-pc_type -pc_hypre_type'
  petsc_options_value = 'hypre boomeramg'
[]

[Outputs]
  output_initial = true
  exodus = true
  print_perf_log = true
  print_linear_residuals = true
[]
