import { faker } from '@faker-js/faker';
import _ from 'lodash';
import { calculateAge } from '../../../helpers/common.helper';
import * as argon2 from '../../../helpers/password.helper';
import { CreateUserProfileDto } from '../../../validations/user-validation';
import { Seeder } from '../database.interface';
import { Gender, PrismaClient } from '../prisma/generated/client';

export default class UserSeeder implements Seeder {
  constructor(private prisma: PrismaClient) {}

  public TOTAL_USER = 100;

  async execute(): Promise<void> {
    await this.seedUser();
  }

  private async seedUser() {
    const users = await this.factoryUser(this.TOTAL_USER);
    return Promise.all(
      users.map(
        async (user) =>
          await this.prisma.user.create({
            data: {
              ..._.omit(user, 'profile', 'roleId'),
              profile: { create: user.profile },
              userHasRoles: { create: { roleId: user.roleId! } },
            },
          }),
      ),
    );
  }

  private async factoryUser(nUser: number = 1) {
    const factories = [];
    const password = await argon2.hash('password');
    const rolesKeyByName = _.keyBy(await this.prisma.role.findMany(), 'name');

    const factory = (username: string): CreateUserProfileDto => {
      const dateOfBirth = faker.date.between({ from: '1990-01-01', to: '2010-12-31' });
      return {
        username,
        password,
        isActive: true,
        profile: {
          fullName: faker.person.fullName(),
          placeOfBirth: faker.location.city(),
          dateOfBirth,
          gender: _.sample([Gender.male, Gender.female]),
          age: calculateAge(dateOfBirth),
        },
      };
    };

    factories.push({ roleId: rolesKeyByName['Developer'].id, ...factory(`developer`) });
    factories.push({ roleId: rolesKeyByName['Admin'].id, ...factory(`admin`) });
    for (let i = 1; i <= nUser; i++)
      factories.push({ roleId: rolesKeyByName['User'].id, ...factory(`user${i}`) });

    return factories;
  }
}
