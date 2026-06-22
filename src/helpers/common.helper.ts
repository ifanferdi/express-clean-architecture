import moment from 'moment';
import AppError from './error.helper';

export const reformatStorageKey = (str: string) =>
  str
    .replace(/\s+/g, '_') // ubah spasi jadi underscore
    .replace(/\/+/g, '/'); // ubah multiple slash jadi single slash

export const isJsonValue = (str: string) => {
  try {
    JSON.parse(str);
    return true;
  } catch {
    return false;
  }
};

export const handleOrderByRequest = <T>(req: Record<string, any>) => {
  if (!req.orderBy) return undefined;
  else {
    if (!(req.orderBy instanceof Array)) throw new AppError('OrderBy must be an array of string.');

    return req.orderBy.map((order: string) => {
      const [field, direction] = order.split(':');
      return { field: field as T, direction: direction as 'asc' | 'desc' };
    });
  }
};

export const handleNumberOrArrayRequest = (value?: string | string[]) => {
  if (!value) return undefined;
  return Array.isArray(value) ? value.map((val: string) => Number(val)) : Number(value);
};
export const calculateAge = (dateOfBirth: Date) => moment().diff(moment(dateOfBirth), 'years');
