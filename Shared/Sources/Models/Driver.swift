//
//  Driver.swift
//  
//
//  Created by Personal James on 29/12/2022.
//

import Foundation

public struct Driver: Codable, Hashable {
  public let name: String
  public let number: Int
  public let team: Constructor

  public static let lewisHamilton: Driver = .init(name: "Lewis Hamilton", number: 44, team: .mercedes)
  public static let georgeRussell: Driver = .init(name: "George Russell", number: 63, team: .mercedes)
  public static let maxVerstappen: Driver = .init(name: "Max Verstappen", number: 1, team: .redBull)
  public static let sergioPerez: Driver = .init(name: "Sergio Perez", number: 11, team: .redBull)
  public static let chrlesLeclerc: Driver = .init(name: "Charles Leclerc", number: 16, team: .ferari)
  public static let carlosSainzs: Driver = .init(name: "Carlos Sainz", number: 55, team: .ferari)
  public static let danielRicciardo: Driver = .init(name: "Daniel Riccardo", number: 3, team: .mcLaren)
  public static let landoNorris: Driver = .init(name: "Lando Norris", number: 4, team: .mcLaren)
  public static let fernandoAlonso: Driver = .init(name: "Fernando Alonso", number: 14, team: .alpine)
  public static let estebanOcon: Driver = .init(name: "Esteban Ocon", number: 31, team: .alpine)
  public static let pierreGasley: Driver = .init(name: "Pierre Gasley", number: 10, team: .alphaTauri)
  public static let yukiTsunoda: Driver = .init(name: "Yuki Tsunoda", number: 22, team: .alphaTauri)
  public static let sebastianVettel: Driver = .init(name: "Sebastian Vettel", number: 5, team: .astonMartin)
  public static let lanceStroll: Driver = .init(name: "Lance Stroll", number: 18, team: .astonMartin)
  public static let nicholasLatifi: Driver = .init(name: "Nicholas Latifi", number: 6, team: .williams)
  public static let alexAlbon: Driver = .init(name: "Alex Albon", number: 23, team: .williams)
  public static let zhouGuanyu: Driver = .init(name: "Zhou Guanyu", number: 24, team: .alphaRomeo)
  public static let valtteriBottas: Driver = .init(name: "Valtteri Bottas", number: 77, team: .alphaRomeo)

  public static let allDrivers: [Driver] = [
    .lewisHamilton,
    .georgeRussell,
    .maxVerstappen,
    .sergioPerez,
    .chrlesLeclerc,
    .carlosSainzs,
    .danielRicciardo,
    .landoNorris,
    .fernandoAlonso,
    .estebanOcon,
    .pierreGasley,
    .yukiTsunoda,
    .sebastianVettel,
    .lanceStroll,
    .nicholasLatifi,
    .alexAlbon,
    .zhouGuanyu,
    .valtteriBottas,
  ]
}
